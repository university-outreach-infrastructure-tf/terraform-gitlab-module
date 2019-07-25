provider "aws" {
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "gitlab" {
  source                            = "../../module/single-node-omnibus/"
  vpc_id                            = var.vpc_id
  namespace                         = "eg"
  name                              = "app"
  stage                             = "test"
  attributes                        = ["xyz"]
  private_subnet_id                 = var.private_subnet_id
  public_subnet_id                  = var.public_subnet_id
  dns_name                          = var.dns_name
  domain_name                       = var.domain_name
  zone_id                           = var.zone_id
  ssh_key_name                      = var.ssh_key_name
  gitlab_application_ami            = var.gitlab_ami
  gitlab_artifactory_s3_bucket_name = var.gitlab_artifactory_s3_bucket_name
  gitlab_lfs_s3_bucket_name         = var.gitlab_lfs_s3_bucket_name
  gitlab_packages_s3_bucket_name    = var.gitlab_packages_s3_bucket_name
  gitlab_registry_s3_bucket_name    = var.gitlab_registry_s3_bucket_name
  gitlab_backup_s3_bucket_name      = var.gitlab_backup_s3_bucket_name
  gitlab_kms_alias                  = var.gitlab_kms_alias
}