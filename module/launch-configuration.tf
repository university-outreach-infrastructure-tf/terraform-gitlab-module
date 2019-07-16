resource "aws_launch_configuration" "gitlab_application" {
  name_prefix     = "${var.name}-gitlab-application"
  image_id        = "${var.gitlab_application_ami}"
  instance_type   = "m4.xlarge"
  security_groups = ["${aws_security_group.gitlab_application.id}", "${aws_security_group.internal_ssh.id}"]
  key_name        = "${var.launch_config_key_name}"
  user_data       = "${data.template_file.gitlab_application_user_data.rendered}"
  lifecycle {
    create_before_destroy = true
  }
}