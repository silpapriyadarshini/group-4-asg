data "aws_ami" "nginx-green" {
  most_recent = true
  owners = ["099720109477"]
  
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# resource "aws_instance" "instance_green" {
#   ami           = data.aws_ami.nginx-green.id
#   instance_type = "t2.small"

#   tags = {
#     Name = "instance-green"
#   }
# }

resource "aws_launch_configuration" "aws-conf-green" {
  name          = "green-config"
  image_id      = data.aws_ami.nginx-green.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "asg_green" {
  #availability_zones = ["ap-south-1a","ap-south-1b"]
  vpc_zone_identifier  = [data.aws_subnet.private_1.id, data.aws_subnet.private_2.id]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  launch_configuration = aws_launch_configuration.aws-conf-green.id

  # launch_configuration {
  #   id      = aws_launch_configuration.aws-conf-green.id
  #   version = "$Latest"
  # }
}

resource "aws_autoscaling_policy" "asg_policy_green" {
  name                   = "asg-policy-green"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_green.name
}