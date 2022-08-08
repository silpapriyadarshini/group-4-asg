data "aws_ami" "apache-green" {
  most_recent = true
  owners = [var.owner_id]

  filter {
    name   = "name"
    values = [var.ami_green]
  }
}

resource "aws_launch_template" "green_temp" {
  name_prefix            = "green_temp"
  image_id               = data.aws_ami.apache-green.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg_green" {
  vpc_zone_identifier  = [
    data.aws_subnet.private_1.id, 
    data.aws_subnet.private_2.id
  ]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 0
  launch_template {
    id      = aws_launch_template.green_temp.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Green-Instance"
    propagate_at_launch = true
  } 
}

resource "aws_autoscaling_policy" "asg_policy_green" {
  name                   = "asg-policy-green"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_green.name
}