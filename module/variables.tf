variable "tags" {
  type        = "map"
  description = "A map of tags to add to all resources"
  default     =  { Name = "Tf-Infra" }
}

variable "force_destroy_s3_bucket" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
  default     =  false
}

variable "project_name_prefix" {
  type        = "string"
  description = "A prefix to add to project resources"
}
