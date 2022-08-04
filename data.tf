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