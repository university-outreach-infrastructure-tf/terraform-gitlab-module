resource "aws_lb" "gitlab_alb" {
  load_balancer_type = "application"
  idle_timeout       = var.gitlab_alb_ideal_timeout
  internal           = false
  security_groups    = [aws_security_group.gitlab_alb.id]
  ip_address_type    = "ipv4"
  subnets            = var.public_subnet_id
  tags               = {"Name" = format("%s-alb", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
}

resource "aws_lb_target_group" "gitlab_alb_tg" {
  port                 = 443
  protocol             = "HTTPS"
  vpc_id               = var.vpc_id
  tags                 = {"Name" = format("%s-alb-tg", module.gitlab_label.name), "Environment" = module.gitlab_label.stage}
  health_check {
    port                = "traffic-port"
    protocol            = "HTTPS"
    interval            = 30
    path                = "/explore"
    timeout             = 15
    healthy_threshold   = 3
    unhealthy_threshold = 10
    matcher             = 200
  }
}

resource "aws_lb_listener" "gitlab_alb_https_listener" {
  load_balancer_arn = aws_lb.gitlab_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.gitlab_cert.arn
  default_action {
    target_group_arn = aws_lb_target_group.gitlab_alb_tg.arn
    type             = "forward"
  }
}


resource "aws_lb_listener" "gitlab_registry_alb_https_listener" {
  load_balancer_arn  = aws_lb.gitlab_alb.arn
  port               = 4000
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = aws_acm_certificate.gitlab_cert.arn
  default_action {
    target_group_arn = aws_lb_target_group.gitlab_alb_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "gitlab_alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.gitlab_alb_tg.arn
  target_id        = aws_instance.gitlab_application.id
  port             = 443
}