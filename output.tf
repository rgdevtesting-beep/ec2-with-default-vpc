# Print the public IP
output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

# Print the public DNS
output "ec2_public_dns" {
  value = aws_instance.web.public_dns
}

# Print the AMI being used
output "ami_id" {
  value = data.aws_ami.amazon_linux.id
}