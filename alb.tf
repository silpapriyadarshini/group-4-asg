resource "aws_lb" "alb_project" {
  name               = "alb-project"
  security_groups    = [aws_security_group.alb_sg.id]
  load_balancer_type = "application"
  subnets            = [data.aws_subnet.public_1.id]

  enable_deletion_protection = true

  tags = {
    Name = "alb-project"
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb_project.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.tg_blue.arn
        weight = 50
      }
    
    target_group {
      arn    = aws_lb_target_group.tg_green.arn
      weight = 50
      }
    }
  }
}