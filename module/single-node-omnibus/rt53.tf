# ---------------------------------------------------------------------------------------------------------------------
# CREATE DNS A RECORDS IN ROUTE 53 FOR CERTIFICATE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.gitlab_cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.gitlab_cert.domain_validation_options.0.resource_record_type
  zone_id = var.zone_id
  records = [aws_acm_certificate.gitlab_cert.domain_validation_options.0.resource_record_value]
  ttl     = 300
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE DNS A RECORDS IN ROUTE 53 POINTING AT THE LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_route53_record" "alb_dns" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.gitlab_alb.dns_name
    zone_id                = aws_lb.gitlab_alb.zone_id
    evaluate_target_health = false
  }
}