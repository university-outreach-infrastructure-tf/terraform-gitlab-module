variable "force_destroy_s3_bucket" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     =  false
}

variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  default     = ""
}

variable "attributes" {
  type        = list
  description = "Additional attributes (e.g. 1)"
  default     = []
}

variable "delimiter" {
  type        = string
  description = "Delimiter to be used between namespace, environment, stage, name and attributes"
  default     = "-"
}

variable "name" {
  type        = "string"
  description = "A prefix to add to project resources"
  default     = ""
}

variable "gitlab_artifactory_s3_bucket_name" {
  type        = string
  description = "Name of Gitlab Artifactory S3 bucket"
  default     = ""
}

variable "gitlab_lfs_s3_bucket_name" {
  type        = string
  description = "Name of Gitlab LFS S3 bucket"
  default     = ""
}

variable "gitlab_backup_s3_bucket_name" {
  type        = string
  description = "Name of Gitlab Backup S3 bucket"
  default     = ""
}

variable "dns_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
  default     = ""
}

variable "domain_name" {
  type        = string
  description = "ALB record53 entry domain name"
  default     = ""
}

variable "public_subnet_id" {
  type        = list
  description = "A list of public subnet IDs to attach"
  default     = []
}

variable "private_subnet_id" {
  type        = list
  description = "A list of private subnet IDs to attach"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC Gitlab will be provisioned in."
  default     = ""
}

variable "gitlab_data_disk_size" {
  description = "The size of gitlab data disk to provision"
  default     = 100
}

variable "gitlab_data_disk_device_name" {
  type        = string
  description = "The name gitlab data disk"
  default     = "/dev/xvdi"
}

variable "git_data_directory" {
  type     = string
  default  = "/mnt/gitlab-data"
}

variable "snapshot_interval" {
  type        = string
  description = "How often this lifecycle policy should be evaluated. 2,3,4,6,8,12 or 24 are valid values. Default 24"
  default     = "24"
}

variable "snapshot_start_time" {
  type        = list
  description = "A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated."
  default     = ["00:00"]
}

variable "retain_rule" {
  description = "How many snapshots to keep. Must be an integer between 1 and 1000."
  default     = 5
}

variable "gitlab_alb_ideal_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = 60
}

variable "rotation_status" {
  type        = string
  description = "Rotation status for S3 IAM user, 0 or 1"
  default     = "1"
}

variable "gitlab_application_ami" {
  type        = string
  description = "AMI of gitlab application to be used with Gitlab instance. AMI can be build using Packer like: https://github.com/university-outreach-infrastructure-tf/gitlab-packer-ami"
  default     = ""
}

variable "zone_id" {
  type        = string
  description = "The ID of the hosted zone to contain Route53 record."
  default     = ""
}

variable "gitlab_kms_alias" {
  type        = string
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash"
  default     = ""
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  default     = true
}

variable "ssh_key_name"{
  type        = string
  description = "SSH key for ec2 ssh"
  default     = ""
}