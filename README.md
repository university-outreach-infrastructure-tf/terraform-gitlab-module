# terraform-gitlab-module

This module assumes following resources are already available:
1. VPC
2. Public Subnet
3. Private Subnet
4. Route table, Route, Route Table Association for public subnet
5. Internet gateway for public subnet
6. Registered Domain Name
7. Route53 Hosted Zone

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
      registry_domain_name              = var.registry_domain_name
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
```

## INPUT VALUES

| Input                             | Description                                                                                                               | Type    | Default            | Required |
| ----------------------------------| --------------------------------------------------------------------------------------------------------------------------| --------|--------------------|----------|
| namespace                         | Namespace, which could be your organization name or abbreviation"                                                         |`string` | ""                 | yes      |
| stage                             | Stage, e.g. 'prod', 'staging', 'dev'                                                                                      |`string` | ""                 | yes      |
| name                              | Solution name, e.g. 'app' or 'jenkins'                                                                                    |`string` | ""                 | yes      |
| attributes                        | Additional attributes                                                                                                     |`list`   | `<list>`           | no       |           
| delimiter                         | Delimiter to be used between namespace, environment, stage, name and attributes                                           |`string` | "-"                | no       |
| force_destroy_s3_bucket           | Boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error.   | `bool`  | `false`            | no       |
| gitlab_artifactory_s3_bucket_name | Name of Gitlab Artifactory S3 bucket                                                                                      | `string`| ""                 | yes      |
| gitlab_lfs_s3_bucket_name         | Name of Gitlab LFS S3 bucket                                                                                              | `string`| ""                 | yes      |
| gitlab_packages_s3_bucket_name    | Name of Gitlab Packages S3 bucket                                                                                         | `string`| ""                 | yes      |
| gitlab_registry_s3_bucket_name    | Name of Gitlab Registry S3 bucket                                                                                         | `string`| ""                 | yes      |
| gitlab_backup_s3_bucket_name      | Name of Gitlab Backup S3 bucket                                                                                           | `string`| ""                 | yes      |
| dns_name                          | Domain name for which the certificate should be issued                                                                    | `string`| ""                 | yes      |
| domain_name                       | ALB record53 entry domain name                                                                                            | `string`| ""                 | yes      |
| registry_domain_name              | ALB record53 entry registry domain name                                                                                   | `string`| ""                 | yes      |
| public_subnet_id                  | List of public subnet IDs to attach                                                                                       | `list`  | `<list>`           | yes      |
| private_subnet_id                 | List of private subnet IDs to attach                                                                                      | `list`  | `<list>`           | yes      |
| vpc_id                            | Id of the VPC Gitlab will be provisioned in                                                                               | `string`| ""                 | yes      |
| gitlab_data_disk_size             | Size of gitlab data disk to provision                                                                                     | `number`| `100`              | no       |
| gitlab_data_disk_device_name      | Name of gitlab data disk                                                                                                  | `string`| `/dev/xvdi`        | no       |
| git_data_directory                | Name of gitlab data disk                                                                                                  | `string`| `/mnt/gitlab-data` | no       |
| snapshot_interval                 | How often this lifecycle policy should be evaluated                                                                       | `string`| `24`               | no       |
| snapshot_start_time               | List of times in 24 hour clock format that sets when the lifecycle policy should be evaluated                             | `string`| `00:00`            | no       |
| retain_rule                       | How many snapshots to keep. Must be an integer between 1 and 1000.                                                        | `number`| `10`               | no       |
| gitlab_alb_ideal_timeout          | Time in seconds that the connection is allowed to be idle.                                                                | `number`| `60`               | no       |
| gitlab_application_ami            | AMI of gitlab application to be used with Gitlab instance.                                                                | `string`| ""                 | yes      |
| zone_id                           | ID of the hosted zone to contain Route53 record.                                                                          | `string`| ""                 | yes      |
| gitlab_kms_alias                  | Display name of KMS Key alias. Name must start with the word `alias` followed by a forward slash                          | `string`| ""                 | yes      |
| enable_key_rotation               | Specifies whether key rotation is enabled                                                                                 | `bool`  | `true`             | no       |
| ssh_key_name                      | SSH key for ec2 ssh                                                                                                       | `string`| ""                 | yes      |

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
| route53_gitlab_registry_alb       | Route53 FQDN for registry                     | 
| bastion_public_eip                | EIP Address of Bastion Instance               | 
| gitlab_private_ip                 | Private IP Address of Gitlab Instance         | 
