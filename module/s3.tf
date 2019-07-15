# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create LFS S3 bucket, More Info: https://docs.gitlab.com/ee/workflow/lfs/lfs_administration.html#s3-for-omnibus-installations
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_lfs_s3_bucket" {
  bucket        = "${var.project_name_prefix}-gitlab-lfs"
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

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", ${aws_s3_bucket.gitlab_lfs_s3_bucket.bucket}))}"
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Artifactory S3 bucket, More Info: https://docs.gitlab.com/ee/administration/job_artifacts.html#object-storage-settings
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_artifactory_s3_bucket" {
  bucket        = "${var.project_name_prefix}-gitlab-artifactory"
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

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", ${aws_s3_bucket.gitlab_artifactory_s3_bucket.bucket}))}"
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Packages S3 bucket, More Info: https://docs.gitlab.com/ee/administration/packages.html#using-object-storage
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_packages_s3_bucket" {
  bucket        = "${var.project_name_prefix}-gitlab-packages"
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

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", ${aws_s3_bucket.gitlab_packages_s3_bucket.bucket}))}"
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Registry S3 bucket, More Info: https://docs.gitlab.com/ee/administration/container_registry.html#container-registry-storage-driver
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_registry_s3_bucket" {
  bucket        = "${var.project_name_prefix}-gitlab-packages"
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

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", ${aws_s3_bucket.gitlab_registry_s3_bucket.bucket}))}"
}

# ---------------------------------------------------------------------------------------------------------------------------------------------
# Create Gitlab Backup S3 bucket, More Info: https://docs.gitlab.com/ee/raketasks/backup_restore.html#using-amazon-s3
# ---------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "gitlab_backups_s3_bucket" {
  bucket        = "${var.project_name_prefix}-gitlab-backups"
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

  tags = "${merge(local.DEFAULT_TAGS, var.tags, map("Name", ${aws_s3_bucket.gitlab_backups_s3_bucket.bucket}))}"
}

locals {
  DEFAULT_TAGS = {
    "managed_by"       = "Terraform Capstone Project"
    "terraform_module" = "s3"
  }
}