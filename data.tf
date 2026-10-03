# Find the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" { 
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["al2023-ami-*-x86_64"]
    }
    filter {
        name = "state"
        values = ["available"]
    }
}

# Get the default VPC
data "aws_vpc" "default" {
    default = true
}

# Get a subnet from the default VPC
data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}