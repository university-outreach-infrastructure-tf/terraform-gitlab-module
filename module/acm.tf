# ---------------------------------------------------------------------------------------------------------------------
# CREATE ACM CERTIFICATE FOR INFLUXDB LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_acm_certificate" "gitlab_cert" {
  domain_name       = "${var.dns_name}"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "gitlab_cert_validation" {
  certificate_arn         = "${aws_acm_certificate.gitlab_cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}