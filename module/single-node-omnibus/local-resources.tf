# use this resource when a module accepts a subnet id as an input variable and needs to, for example, determine the id of the VPC that the subnet belongs to.
data "aws_subnet" "private_selected" {
  id = "${element (["${var.private_subnet_id}"], 0)}"
}

data "aws_subnet" "public_selected" {
  id = "${element (["${var.public_subnet_id}"], 0)}"
}

# Use this data source to get the access to the effective Account ID, User ID, and ARN in which Terraform is authorized.
data "aws_caller_identity" "current" {}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "product-code"
    values = ["aw0evgkw8e5c1q413zgy5pjce"]
  }

  owners = ["aws-marketplace"]
}

data "template_file" "gitlab_application_user_data" {
  template = "${file("${path.module}/templates/gitlab_application_user_data.tpl")}"

  vars = {
    git_data_disk                   = "${var.gitlab_data_disk_device_name}"
    git_data_disk_mount_point       = "${var.git_data_directory}"
    s3_bucket_name                  = "${var.gitlab_artifactory_s3_bucket_name}"
    s3_bucket_provider              = "AWS"
    s3_bucket_region                = "us-east-1"
    s3_bucket_user_access_key       = "${aws_iam_access_key.s3_access_key.id}"
    s3_bucket_user_secret_key       = "${aws_iam_access_key.s3_access_key.secret}"
    artifactory_s3_bucket_name      = "${var.gitlab_artifactory_s3_bucket_name}"
    lfs_s3_bucket_name              = "${var.gitlab_lfs_s3_bucket_name}"
    packages_s3_bucket_name         = "${var.gitlab_packages_s3_bucket_name}"
    registry_s3_bucket_name         = "${var.gitlab_registry_s3_bucket_name}"
    domain_name                     = "${var.domain_name}"
  }
}

data "template_cloudinit_config" "config" {
  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.gitlab_application_user_data.rendered}"
  }
}

