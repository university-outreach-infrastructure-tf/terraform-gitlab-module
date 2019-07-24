resource "aws_instance" "bastion" {
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnet.public_selected.id
  security_groups = [aws_security_group.external_ssh.id]
  key_name        = var.ssh_key_name
  ami             = data.aws_ami.centos.id
  volume_tags     = { "Name" = format("%s-bastion-ebs", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
  tags            = { "Name" = format("%s-bastion", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
}

resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true
  tags     = { "Name" = format("%s-bastion-eip", module.gitlab_label.name), "Environment"= module.gitlab_label.stage}
}
