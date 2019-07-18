resource "aws_instance" "gitlab_application" {
  name            = "${var.name}-application"
  instance_type   = "m4.xlarge"
  subnet_id       = "${data.aws_subnet.private_selected.id}"
  security_groups = ["${aws_security_group.gitlab_application.id}", "${aws_security_group.internal_ssh.id}"]
  key_name        = "${var.launch_config_key_name}"
  user_data       = "${data.template_file.gitlab_application_user_data.rendered}"
  ami             = "${var.gitlab_application_ami}"
  tags   = "${
  merge(
    map(
       "Name", "${module.gitlab_label.name}",
       "Role", "${replace(module.gitlab_label.name, "-", "_")}"
    )
  )}"
}