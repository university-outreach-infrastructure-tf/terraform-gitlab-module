# terraform-gitlab-module

This module assumes following resources are already available:
1. VPC
2. Public Subnet
3. Private Subnet
5. Route table, Route, Route Table Association for public subnet
6. Internet gateway for public subnet
4. Registered Domain Name
5. Route53 Hosted Zone

and it creates following resources:

1. Gitlab Instance
2. ALB for Gitlab
3. Certificate for Gitlab instance
4. IAM user 
5. SSH Key Pair
6. KMS Key
7. Route53 entry
8. S3 Buckets
9. Security Groups
10. Bastion Host

Usage:
```
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
}
```

## INPUT VALUES

| Input             | Description                                                                    | Type    | Default | Required |
| ------------------| -------------------------------------------------------------------------------| --------|---------|----------|
| namespace         | Namespace, which could be your organization name or abbreviation"              |`string` | ""      | yes      |
| stage             | Stage, e.g. 'prod', 'staging', 'dev'                                           |`string` | ""      | yes      |
| name              | Solution name, e.g. 'app' or 'jenkins'                                         |`string` | ""      | yes      |
| attributes        | Additional attributes                                                          |`list`   | `<list>`| no       |           
| delimiter         | Delimiter to be used between namespace, environment, stage, name and attributes|`string` | "-"     | no       |

## OUTPUT VALUE NAMES

| Name                              | Description                                   | 
| ----------------------------------| ----------------------------------------------| 
| gitlab_artifactory_s3_bucket_id   | Gitlab artifactory S3 bucket Name             | 
| gitlab_artifactory_s3_bucket_arn  | Gitlab artifactory S3 bucket ARN              | 
| gitlab_registry_s3_bucket_id      | Gitlab registry S3 bucket Name                | 
| gitlab_registry_s3_bucket_arn     | Gitlab registry S3 bucket ARN                 | 
| gitlab_packages_s3_bucket_id      | Gitlab packages S3 bucket Name                |
| gitlab_packages_s3_bucket_arn     | Gitlab packages S3 bucket ARN                 | 
| gitlab_lfs_s3_bucket_id           | Gitlab LFS S3 bucket Name                     | 
| gitlab_lfs_s3_bucket_arn          | Gitlab LFS S3 bucket ARN                      | 
| s3_secret_key                     | S3 IAM User secret key                        | 
| s3_access_key                     | S3 IAM User access key                        | 
| user_arn                          | S3 IAM User ARN                               | 
| sg_internal_ssh_name              | Security Group name for internal SSH          | 
| sg_internal_ssh_ingress           | Security Group ingress Rules internal SSH     | 
| sg_external_ssh_name              | Security Group name for bastion               | 
| sg_external_ssh_ingress           | Security Group ingress rules for bastion      | 
| sg_gitlab_alb_name                | Security Group name for ALB                   | 
| sg_gitlab_alb_ingress             | Security Group ingress rules ALB              | 
| sg_internal_gitlab_name           | Security Group name for gitlab instance       | 
| sg_internal_gitlab_ingress        | Security Group ingress rules gitlab instance  | 
| acm_cert_arn                      | ACM Certificate ARN                           | 
| route53_cert_validation           | ALB Route53 FQDN                              | 
| route53_gitlab_alb                | Route53 FQDN for gitlab instance              | 
| bastion_public_eip                | EIP Address of Bastion Instance               | 
| gitlab_private_ip                 | Private IP Address of Gitlab Instance         | 