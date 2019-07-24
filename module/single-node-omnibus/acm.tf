resource "aws_acm_certificate" "gitlab_cert" {
  domain_name       = "${var.dns_name}"
  validation_method = "DNS"
  tags              = "${module.gitlab_label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "gitlab_cert_validation" {
  certificate_arn         = "${aws_acm_certificate.gitlab_cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}