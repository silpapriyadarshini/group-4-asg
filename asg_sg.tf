resource "aws_security_group" "asg_sg" {
  name        = "autoscaling_sg"
  description = "Allow connection for load balancer and bastion host inbound traffic"
  vpc_id      = data.aws_vpc.grp4_vpc.id
# yhyhuh
  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    # cidr_blocks      = ["122.169.90.78/32"]
    cidr_blocks      = [ "0.0.0.0/0" ]
  }
  ingress {
    description      = "Allow port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    # cidr_blocks      = ["122.169.90.78/32"]
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "asg_sg"
  }
}
