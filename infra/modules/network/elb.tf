########

resource "aws_lb_target_group" "tg" {
  name        = "k3s-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.GetVPC.id
  target_type = "instance"

  health_check {
    matcher = "200,404"
  }
}

resource "aws_lb_target_group_attachment" "tga" {
  count            = length(data.aws_instances.ec2_list.ids)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = data.aws_instances.ec2_list.ids[count.index]
  port             = 80
}

resource "aws_security_group" "elb_sg" {
  name        = "allow_http_elb"
  description = "Allow http inbound traffic for elb"
  vpc_id      = data.aws_vpc.GetVPC.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "k3s-elb-security-group"
  }
}

resource "aws_lb" "k3s-elb" {
  name            = "k3s-elb"
  subnets         = data.aws_subnets.public_subnets.ids
  security_groups = [aws_security_group.elb_sg.id]
  tags = {
    Name = "k3s-elb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.k3s-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.tg.arn
      }
      stickiness {
        enabled  = true
        duration = 28800
      }
    }
  }
}