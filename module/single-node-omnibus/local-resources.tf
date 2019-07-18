# use this resource when a module accepts a subnet id as an input variable and needs to, for example, determine the id of the VPC that the subnet belongs to.
data "aws_subnet" "private_selected" {
  id = "${element (var.private_subnet_id, 0)}"
}

data "aws_subnet" "public_selected" {
  id = "${element (var.public_subnet_id, 0)}"
}

# Use this data source to get the access to the effective Account ID, User ID, and ARN in which Terraform is authorized.
data "aws_caller_identity" "current" {}

# Use this data source to find a Hosted Zone ID given Hosted Zone name.
data "aws_route53_zone" "zone_selected" {
  name         = "${var.dns_name}."
}

data "template_file" "gitlab_application_user_data" {
  template = "${file("${path.module}/single-node-omnibus/templates/gitlab_application_user_data.sh")}"

  vars {
    gitlab_data_disk = "${var.gitlab_data_disk_device_name}"
  }
}