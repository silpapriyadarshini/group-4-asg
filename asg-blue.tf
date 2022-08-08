data "aws_ami" "apache-blue" {
  most_recent = true
  owners = [var.owner_id]
  
  filter {
    name   = "name"
    values = [var.ami_blue]
  }
}

resource "aws_launch_template" "blue_temp" {
  name_prefix            = "blue_temp"
  image_id               = data.aws_ami.apache-blue.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg_blue" {
  vpc_zone_identifier  = [
    data.aws_subnet.private_1.id, 
    data.aws_subnet.private_2.id
  ]
  desired_capacity     = 2
  max_size             = 2
  min_size             = 0

  launch_template {
    id      = aws_launch_template.blue_temp.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Blue-Instance"
    propagate_at_launch = true
  } 
}

resource "aws_autoscaling_policy" "asg_policy_blue" {
  name                   = "asg-policy-blue"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_blue.name
}