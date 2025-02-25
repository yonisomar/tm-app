# Define Application Load Balancer (ALB)
resource "aws_lb" "tm_app_alb" {
  name               = var.alb_name
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnet_ids
  tags = {
    Name = "tm_app_alb"
  }
}

# Define Target Group for ALB
resource "aws_lb_target_group" "tm_app_alb_target_group" {
  name        = var.alb_target_group_name
  port        = var.alb_target_group_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "tm-app-alb-target-group"
  }
}

# Define Listener for HTTP (to redirect to HTTPS)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.tm_app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Define Listener for HTTPS
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.tm_app_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_certificate_arn

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.tm_app_alb_target_group.arn
        weight = 1
      }
    }
  }
}