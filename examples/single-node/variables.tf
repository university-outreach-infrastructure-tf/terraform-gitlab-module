variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
  default = ""
}

variable "vpc_id" {
}

variable "public_subnet_id" {
}

variable "private_subnet_id" {
}

variable "dns_name" {
}

variable "domain_name" {
}

variable "zone_id" {
}

variable "gitlab_ami" {
}

variable "ssh_key_name"{
}

variable "gitlab_artifactory_s3_bucket_name" {
}

variable "gitlab_lfs_s3_bucket_name" {
}

variable "gitlab_packages_s3_bucket_name" {
}

variable "gitlab_registry_s3_bucket_name" {
}

variable "gitlab_backup_s3_bucket_name" {
}

variable "gitlab_kms_alias" {
}