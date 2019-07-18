resource "aws_instance" "bastion" {
  instance_type   = "t2.micro"
  subnet_id       = "${data.aws_subnet.public_selected.id}"
  security_groups = ["${aws_security_group.external_ssh.id}"]
  key_name        = "${module.ssh_key_pair.key_name}"
  ami             = "${data.aws_ami.centos.id}"
  tags   = "${
  merge(
    map(
       "Name", "${module.gitlab_label.name}-bastion",
       "Role", "${replace(module.gitlab_label.name, "-", "_")}"
    )
  )}"
}