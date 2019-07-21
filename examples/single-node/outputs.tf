output "gitlab_artifactory_s3_bucket_id" {
  value = module.gitlab.gitlab_artifactory_s3_bucket_id
}

output "gitlab_artifactory_s3_bucket_arn" {
  value = module.gitlab.gitlab_artifactory_s3_bucket_arn
}

output "gitlab_packages_s3_bucket_id" {
  value = module.gitlab.gitlab_packages_s3_bucket_id
}

output "gitlab_packages_s3_bucket_arn" {
  value = module.gitlab.gitlab_packages_s3_bucket_arn
}

output "gitlab_registry_s3_bucket_id" {
  value = module.gitlab.gitlab_registry_s3_bucket_id
}

output "gitlab_registry_s3_bucket_arn" {
  value = module.gitlab.gitlab_registry_s3_bucket_arn
}

output "gitlab_lfs_s3_bucket_id" {
  value = module.gitlab.gitlab_lfs_s3_bucket_id
}

output "gitlab_lfs_s3_bucket_arn" {
  value = module.gitlab.gitlab_lfs_s3_bucket_arn
}

output "s3_secret_key" {
  value = "${module.gitlab.s3_secret_key}"
}

output "s3_access_key" {
  value = "${module.gitlab.s3_access_key}"
}

output "user_arn" {
  value = module.gitlab.user_arn
}

output "sg_internal_ssh_name" {
  value = module.gitlab.sg_internal_ssh_name
}

output "sg_internal_ssh_ingress" {
  value = module.gitlab.sg_internal_ssh_ingress
}

output "sg_external_ssh_name" {
  value = module.gitlab.sg_external_ssh_name
}

output "sg_external_ssh_ingress" {
  value = module.gitlab.sg_external_ssh_ingress
}

output "sg_gitlab_alb_name" {
  value = module.gitlab.sg_gitlab_alb_name
}

output "sg_gitlab_alb_ingress" {
  value = module.gitlab.sg_gitlab_alb_ingress
}

output "sg_internal_gitlab_name" {
  value = module.gitlab.sg_internal_gitlab_name
}

output "sg_internal_gitlab_ingress" {
  value = module.gitlab.sg_internal_gitlab_ingress
}

output "acm_cert_arn" {
  value = module.gitlab.acm_cert_arn
}

output "route53_cert_validation" {
  value = module.gitlab.route53_cert_validation
}

output "route53_gitlab_alb" {
  value = module.gitlab.route53_gitlab_alb
}

output "bastion_public_eip" {
  value = module.gitlab.bastion_public_eip
}

output "gitlab_private_ip" {
  value = module.gitlab.gitlab_private_ip
}

