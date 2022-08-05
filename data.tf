data "aws_vpc" "grp4_vpc" {
    filter {
        name   = "tag:Name"
        values = ["grp4_vpc"]
    }
}

data "aws_subnet" "public_1" {
    filter {
        name   = "tag:Name"
        values = ["public_subnet_1"]
    }
}

data "aws_subnet" "public_2" {
  filter {
        name   = "tag:Name"
        values = ["public_subnet_2"] 
  }
}


data "aws_subnet" "private_1" {
  filter {
      name   = "tag:Name"
      values = ["private_subnet_1"] 
  }
}

data "aws_subnet" "private_2" {
  filter {
      name   = "tag:Name"
      values = ["private_subnet_2"] 
  }
}

data "aws_security_group" "asg_sg" {
  filter {
      name   = "tag:Name"
      values = ["asg_sg"] 
  }
}