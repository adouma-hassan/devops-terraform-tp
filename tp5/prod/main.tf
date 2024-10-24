provider "aws" {
  region     = "us-east-1"
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_ACCESS_KEY"

}

terraform {
  backend "s3" {
    bucket = "terraform-backend-adouma"
    key    = "adouma-prod.tfstate"
    region = "us-east-1"
    access_key = "YOUR_ACCESS_KEY"
    secret_key = "YOUR_ACCESS_KEY"
  }
  
}

module "ec2" {
    source = "../modules/ec2module"
    instancetype = "t2.micro"
    aws_common_tag = {
      Name = "ec2-prod-adouma"
    }
    sg_name = "prod-adouma-sg"

}
