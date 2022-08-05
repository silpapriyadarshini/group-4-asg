resource  "aws_alb_target_group" "tg_blue" {
  name     = "alb-tg-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.grp4_vpc.id

  health_check {
    port = 80
    protocol = "HTTP"
  }
}

# resource "aws_lb_target_group_attachment" "blue" {
#   #target_group_arn = aws_launch_configuration.aws-conf-blue.arn
#   target_group_arn = aws_alb_target_group.tg_blue.arn
#   #target_id        = aws_lb.alb_project.arn
#   target_id        = aws_launch_configuration.aws-conf-blue.arn
#   port             = 80
# }

resource "aws_autoscaling_attachment" "asg_attachment_blue" {
    autoscaling_group_name =  aws_autoscaling_group.asg_blue.id
    lb_target_group_arn = aws_alb_target_group.tg_blue.arn
}