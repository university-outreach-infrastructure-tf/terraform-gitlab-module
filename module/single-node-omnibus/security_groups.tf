resource "aws_security_group" "internal_ssh" {
  name_prefix = format("%s-%s-internal-ssh-", module.gitlab_label.name, module.gitlab_label.stage)
  description = "Allows ssh from bastion"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-internal-ssh",module.gitlab_label.name),"Environment" = module.gitlab_label.stage }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.external_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "external_ssh" {
  name_prefix = format("%s-%s-external-ssh-", module.gitlab_label.name, module.gitlab_label.stage)
  description = "Allows ssh from the world"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-external-ssh",module.gitlab_label.name), "Environment" = module.gitlab_label.stage }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "gitlab_alb" {
  name_prefix = format("%s-%s-external-alb-", module.gitlab_label.name, module.gitlab_label.stage)
  description = "Security group to allow all inbound web traffic from world to Load balancer"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-gitlab-alb-instance",module.gitlab_label.name), "Environment" = module.gitlab_label.stage }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "internal_gitlab" {
  name_prefix = format("%s-%s-internal-gitlab-", module.gitlab_label.name, module.gitlab_label.stage)
  description = "Security group to allow all inbound web traffic from Load balancer to gitlab application"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-internal-gitlab-instance",module.gitlab_label.name), "Environment"= module.gitlab_label.stage }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.gitlab_alb.id}"]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.gitlab_alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
