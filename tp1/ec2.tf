provider "aws" {
    region = "us-east-1"
    access_key = "VOTRE_ACCESS_KEY"
    secret_key = "VOTRE_SECRET_KEY"


}


resource "aws_instance" "myec2" {
    ami = "ami-06b21ccaeff8cd686"
    instance_type = "t2.micro"
    key_name = "devops-adouma"
    tags = {
        Name = "ec2-adouma"
    }
}
