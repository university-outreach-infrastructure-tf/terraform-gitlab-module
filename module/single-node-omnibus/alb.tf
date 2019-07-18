# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN APPLICATION LOAD BALANCER FOR INFLUXDB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb" "gitlab_alb" {
  load_balancer_type = "application"
  idle_timeout       = "${var.gitlab_alb_ideal_timeout}"
  internal           = true
  security_groups    = ["${aws_security_group.gitlab_alb.id}"]
  ip_address_type    = "ipv4"
  subnets            = ["${var.public_subnet_id}"]
  tags               = "${merge (module.gitlab_label.tags, map ("Role", "module.gitlab_label.name" ))}"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A TARGET GROUP
# This will perform health checks on the servers and receive requests from the Listerers that match Listener Rules.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_target_group" "gitlab_alb_tg" {
  port                 = 443
  protocol             = "HTTPS"
  vpc_id               = "${var.vpc_id}"

  health_check {
    port                = "traffic-port"
    protocol            = "HTTPS"
    interval            = 30
    path                = "/health"
    timeout             = 15
    healthy_threshold   = 3
    unhealthy_threshold = 10
    matcher             = 200
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE HTTP LISTENERS FOR INFLUXDB ALB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_listener" "gitlab_alb_https_listener" {
  load_balancer_arn = "${aws_lb.gitlab_alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${aws_acm_certificate.gitlab_cert.arn}"
  default_action {
    target_group_arn = "${aws_lb_target_group.gitlab_alb_tg.arn}"
    type             = "forward"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# ATTACH THE INFLUXDB INSTANCE TO THE LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_lb_target_group_attachment" "gitlab_alb_tg_attachment" {
  target_group_arn = "${aws_lb_target_group.gitlab_alb_tg.arn}"
  target_id        = "${aws_instance.gitlab_application.id}"
  port             = 443
}