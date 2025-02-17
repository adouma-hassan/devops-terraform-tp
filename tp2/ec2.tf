
provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_ACCESS_KEY"

}



data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "myec2" {
  ami                    = data.aws_ami.app_ami.id
  instance_type          = var.instancetype
  key_name               = "devops-adouma"
  tags                   = var.aws_common_tag
  vpc_security_group_ids = [aws_security_group.allow_http_https.id]

}

resource "aws_security_group" "allow_http_https" {
  name        = "adouma-sg"
  description = "Allow http and https inbound traffic"


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "ib" {
  instance = aws_instance.myec2.id
  domain   = "vpc"
}