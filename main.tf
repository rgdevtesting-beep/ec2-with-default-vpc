# Security group
resource "aws_security_group" "ec2_sg" {
  name        = "terraform-beginner-ec2-sg"
  description = "Security group for beginner Terraform EC2"
  vpc_id      = data.aws_vpc.default.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-beginner-ec2-sg"
  }
}

# EC2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = data.aws_subnets.default.ids[0]

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  # Install Apache when EC2 starts
  user_data = <<-EOF
              #!/bin/bash

              dnf update -y
              dnf install -y httpd

              systemctl enable httpd
              systemctl start httpd

              echo "<h1>Hello from Terraform EC2!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name        = "terraform-beginner-ec2"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}