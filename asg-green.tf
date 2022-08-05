data "aws_ami" "nginx-green" {
  most_recent = true
  owners = ["699330879220"]

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "image-id"
    values = ["ami-02a0ce8867b366954"]
  }
}

resource "aws_launch_configuration" "aws-conf-green" {
  name            = "green-config"
  image_id        = data.aws_ami.nginx-green.id
  instance_type   = "t3.small"
  security_groups = [data.aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "asg_green" {
  vpc_zone_identifier  = [
    data.aws_subnet.private_1.id, 
    data.aws_subnet.private_2.id
  ]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  launch_configuration = aws_launch_configuration.aws-conf-green.name
}

resource "aws_autoscaling_policy" "asg_policy_green" {
  name                   = "asg-policy-green"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_green.name
}