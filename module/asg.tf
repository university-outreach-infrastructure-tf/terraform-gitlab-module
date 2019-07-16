resource "aws_autoscaling_group" "gitlab_application" {
  launch_configuration = "${aws_launch_configuration.gitlab_application.name}"
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier  = ["${var.private_subnet_ids}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_gitlab" {
  autoscaling_group_name = "${aws_autoscaling_group.gitlab_application.id}"
  elb                    = "${aws_lb.gitlab_alb.id}"
}