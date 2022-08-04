#2. add count and target id in target group attachment

resource "aws_alb_target_group" "tg_green" {
  name     = "alb-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.grp4_vpc.id

  # health_check {
  #   port = 80
  #   protocol = "HTTP"
  # }
}

resource "aws_lb_target_group_attachment" "green" {
  target_group_arn = aws_alb_target_group.tg_green.arn
  target_id        = aws_autoscaling_group.asg_green.arn
  port             = 80
}