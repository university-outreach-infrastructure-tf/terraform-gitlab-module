module "ssh_key_pair" {
  source                = "git::https://github.com/cloudposse/terraform-aws-ssm-tls-ssh-key-pair.git?ref=tags/0.3.0"
  namespace             = "${var.namespace}"
  stage                 = "${var.stage}"
  name                  = "${var.name}"
  ssh_public_key_path   = "${var.public_key_path}"
  ssm_path_format       = "${var.ssm_path_format}"
  ssm_path_prefix       = "${var.ssm_path_prefix}"
  generate_ssh_key      = "true"
  private_key_extension = "${var.private_key_extension}"
}