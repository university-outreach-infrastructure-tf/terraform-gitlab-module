# -----------------------------------------------------------------------------------------------------------
# S3 Outputs
# -----------------------------------------------------------------------------------------------------------
output "gitlab_lfs_s3_bucket_id" {
  value = "${aws_s3_bucket.gitlab_s3_bucket.*.id}"
}

output "gitlab_lfs_s3_bucket_arn" {
  value = "${aws_s3_bucket.gitlab_s3_bucket.*.arn}"
}

output "secret_key" {
  value = "${aws_iam_access_key.access_key_1.*.secret}"
}

output "access_key" {
  value = "${aws_iam_access_key.access_key_1.*.id}"
}

output "user_arn" {
  value = "${aws_iam_user.s3_user.arn}"
}

output "sg_internal_ssh_name" {
  value = "${aws_security_group.internal_ssh.name}"
}

output "sg_internal_ssh_ingress" {
  value = "${aws_security_group.internal_ssh.ingress}"
}

output "sg_external_ssh_name" {
  value = "${aws_security_group.external_ssh.name}"
}

output "sg_external_ssh_ingress" {
  value = "${aws_security_group.external_ssh.ingress}"
}

output "sg_gitlab_alb_name" {
  value = "${aws_security_group.gitlab_alb.name}"
}

output "sg_gitlab_alb_ingress" {
  value = "${aws_security_group.gitlab_alb.ingress}"
}

output "sg_internal_gitlab_name" {
  value = "${aws_security_group.internal_gitlab.name}"
}

output "sg_internal_gitlab_ingress" {
  value = "${aws_security_group.internal_gitlab.ingress}"
}

output "acm_cert_arn" {
  value = "${aws_acm_certificate.gitlab_cert.arn}"
}

output "route53_cert_validation" {
  value = "${aws_route53_record.cert_validation.fqdn}"
}

output "route53_gitlab_alb" {
  value = "${aws_route53_record.alb_dns.fqdn}"
}

output "ssh_key_private_key_name" {
  value = "${module.ssh_key_pair.private_key_filename}"
}

output "ssh_key_public_key_name" {
  value = "${module.ssh_key_pair.public_key_filename}"
}

output "ssh_key_public_key_value" {
  value = "${module.ssh_key_pair.public_key}"
}