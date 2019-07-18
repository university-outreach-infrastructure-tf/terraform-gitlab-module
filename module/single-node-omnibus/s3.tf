# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create LFS S3 bucket, More Info: https://docs.gitlab.com/ee/workflow/lfs/lfs_administration.html#s3-for-omnibus-installations
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_s3_bucket" {
  count         = length(var.s3_buckets)
  bucket        = var.s3_buckets[count.index]
  acl           = "private"
  force_destroy = "${var.force_destroy_s3_bucket}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", var.s3_buckets[count.index]))}"
}

locals {
  DEFAULT_TAGS = {
    "managed_by"       = "Terraform Capstone Project"
    "terraform_module" = "s3"
  }
}