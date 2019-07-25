resource "aws_instance" "gitlab_application" {
  ami                         = var.gitlab_application_ami
  instance_type               = "m4.xlarge"
  subnet_id                   = data.aws_subnet.private_selected.id
  vpc_security_group_ids      = flatten([aws_security_group.internal_ssh.id ,aws_security_group.internal_gitlab.id])
  key_name                    = var.ssh_key_name
  user_data                   = data.template_cloudinit_config.config.rendered
  associate_public_ip_address = false
  monitoring                  = true
  volume_tags                 = { "Name" = format("%s-instance-ebs", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
  tags                        = { "Name" = format("%s-instance", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
}