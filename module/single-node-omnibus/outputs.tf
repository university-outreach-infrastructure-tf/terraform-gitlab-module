output "gitlab_artifactory_s3_bucket_id" {
  value = aws_s3_bucket.gitlab_artifactory_s3_bucket.id
}

output "gitlab_artifactory_s3_bucket_arn" {
  value = aws_s3_bucket.gitlab_artifactory_s3_bucket.arn
}

output "gitlab_registry_s3_bucket_id" {
  value = aws_s3_bucket.gitlab_registry_s3_bucket.id
}

output "gitlab_registry_s3_bucket_arn" {
  value = aws_s3_bucket.gitlab_registry_s3_bucket.arn
}

output "gitlab_packages_s3_bucket_id" {
  value = aws_s3_bucket.gitlab_packages_s3_bucket.id
}

output "gitlab_packages_s3_bucket_arn" {
  value = aws_s3_bucket.gitlab_packages_s3_bucket.arn
}

output "gitlab_lfs_s3_bucket_id" {
  value = aws_s3_bucket.gitlab_lfs_s3_bucket.id
}

output "gitlab_lfs_s3_bucket_arn" {
  value = aws_s3_bucket.gitlab_lfs_s3_bucket.arn
}

output "s3_secret_key" {
  value = aws_iam_access_key.s3_access_key.secret
}

output "s3_access_key" {
  value = aws_iam_access_key.s3_access_key.id
}

output "user_arn" {
  value = aws_iam_user.s3_user.arn
}

output "sg_internal_ssh_name" {
  value = aws_security_group.internal_ssh.name
}

output "sg_internal_ssh_ingress" {
  value = aws_security_group.internal_ssh.ingress
}

output "sg_external_ssh_name" {
  value = aws_security_group.external_ssh.name
}

output "sg_external_ssh_ingress" {
  value = aws_security_group.external_ssh.ingress
}

output "sg_gitlab_alb_name" {
  value = aws_security_group.gitlab_alb.name
}

output "sg_gitlab_alb_ingress" {
  value = aws_security_group.gitlab_alb.ingress
}

output "sg_internal_gitlab_name" {
  value = aws_security_group.internal_gitlab.name
}

output "sg_internal_gitlab_ingress" {
  value = aws_security_group.internal_gitlab.ingress
}

output "acm_cert_arn" {
  value = aws_acm_certificate.gitlab_cert.arn
}

output "route53_cert_validation" {
  value = aws_route53_record.cert_validation.fqdn
}

output "route53_gitlab_alb" {
  value = aws_route53_record.alb_dns.fqdn
}

output "bastion_public_eip" {
  value = aws_eip.bastion.public_ip
}

output "gitlab_private_ip" {
  value = aws_instance.gitlab_application.private_ip
}
