# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Artifactory S3 bucket
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_artifactory_s3_bucket" {
  bucket        = format("%s-%s",module.gitlab_label.id, var.gitlab_artifactory_s3_bucket_name)
  acl           = "private"
  force_destroy = var.force_destroy_s3_bucket

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

  tags = merge(module.gitlab_label.tags,  {"Bucket-Name" = format("%s-%s",module.gitlab_label.id, var.gitlab_artifactory_s3_bucket_name)})
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create LFS S3 bucket
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_lfs_s3_bucket" {
  bucket        = format("%s-%s",module.gitlab_label.id, var.gitlab_lfs_s3_bucket_name)
  acl           = "private"
  force_destroy = var.force_destroy_s3_bucket

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

  tags = merge(module.gitlab_label.tags,  {"Bucket-Name" = format("%s-%s",module.gitlab_label.id, var.gitlab_lfs_s3_bucket_name)})
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Packages S3 bucket
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_packages_s3_bucket" {
  bucket        = format("%s-%s",module.gitlab_label.id, var.gitlab_packages_s3_bucket_name)
  acl           = "private"
  force_destroy = var.force_destroy_s3_bucket

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

  tags = merge(module.gitlab_label.tags,  {"Bucket-Name" = format("%s-%s",module.gitlab_label.id, var.gitlab_packages_s3_bucket_name)})
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Registry S3 bucket
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_registry_s3_bucket" {
  bucket        = format("%s-%s",module.gitlab_label.id, var.gitlab_registry_s3_bucket_name)
  acl           = "private"
  force_destroy = var.force_destroy_s3_bucket

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

  tags = merge(module.gitlab_label.tags,  {"Bucket-Name" = format("%s-%s",module.gitlab_label.id, var.gitlab_registry_s3_bucket_name)})
}