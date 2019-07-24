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
  private_key_extension             = ".pem"
  public_key_extension              = ".pub"
  public_key_path                   = "./secrets"
  gitlab_application_ami            = var.gitlab_ami
  gitlab_artifactory_s3_bucket_name = "gitlab-artifactory"
  gitlab_lfs_s3_bucket_name         = "gitlab-lfs"
  gitlab_packages_s3_bucket_name    = "gitlab-packages"
  gitlab_registry_s3_bucket_name    = "gitlab-registry"
  contact_email                     = "abhimanyunarwal@northwesternmutual.com"
  gitlab_application_comman_name    = var.gitlab_application_comman_name
  ssl_cert_country                  = var.ssl_cert_country
  ssl_cert_state                    = var.ssl_cert_state
  ssl_cert_locality                 = var.ssl_cert_locality
  ssl_cert_org                      = var.ssl_cert_org
  ssl_cert_org_unit                 = var.ssl_cert_org_unit
  ssl_cert_email                    = var.ssl_cert_email
}

