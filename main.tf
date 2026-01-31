provider "aws" {
  region = "ap-south-1"  # Choose your AWS region
}

resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-019715e0d74f695be"  # Replace with a valid AMI ID in your region
  instance_type = "t3.micro"
  
  # Private IP
  private_ip = cidrhost("10.0.0.0/24", count.index + 10)

  tags = {
    Name = "webserver-${count.index + 1}"
    Role = "webserver"
  }
}

output "web_instance_ips" {
  value = aws_instance.web[*].private_ip
}
