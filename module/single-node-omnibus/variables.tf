variable "tags" {
  type        = "map"
  description = "A map of tags to add to all resources"
  default     =  { Name = "Tf-Infra" }
}

variable "force_destroy_s3_bucket" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     =  false
}

variable "name" {
  type        = "string"
  description = "A prefix to add to project resources"
  default     = "gitlab"
}

variable "s3_buckets" {
  type        = "list"
  description = "List of all the s3 bucket user wants to create"
}

variable "dns_name" {
  type        = "string"
  description = "A domain name for which the certificate should be issued"
}

variable "subnet_id" {
  type        = "list"
  description = "A list of subnet IDs to attach to the LB"
}

variable "vpc_id" {
  description = "Id of the VPC Gitlab will be provisioned in."
}

variable "gitlab_data_disk_size" {
  description = "The size of the wal disks to provision"
  default = 100
}

variable "gitlab_data_disk_device_name" {
  description = "The name of the meta device"
  default  = "/dev/xvdi"
}

variable "snapshot_interval" {
  description = "How often this lifecycle policy should be evaluated. 2,3,4,6,8,12 or 24 are valid values. Default 24"
  default = "24"
}

variable "snapshot_start_time" {
  description = "A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated."
  default = "00:00"
}

variable "retain_rule" {
  description = "How many snapshots to keep. Must be an integer between 1 and 1000."
  default = "3"
}

variable "gitlab_alb_ideal_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default = 60
}

variable "private_subnet_ids" {
  type = "list"
  description = "A list of subnet IDs to launch resources in."
}

variable "rotation_status" {
  default = "1"
}

variable "gitlab_application_ami" {
  description = "AMI of gitlab application to be used with Launch Configuration"
}

variable "launch_config_key_name" {
  description = "The key name that should be used for the instance."
}
variable "zone_id" {
  description = "The ID of the hosted zone to contain this record."
  default = ""
}
