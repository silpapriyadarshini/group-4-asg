resource "aws_alb_target_group" "tg_green" {
  name     = "alb-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.grp4_vpc.id

  health_check {
    port = 80
    protocol = "HTTP"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_green" {
    autoscaling_group_name =  aws_autoscaling_group.asg_green.id
    lb_target_group_arn = aws_alb_target_group.tg_green.id
}