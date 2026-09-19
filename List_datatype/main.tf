provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "terraform_security_group" {
  name        = "terraform_security_group"
  description = "Security group for Terraform instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/32"]
  }
}

resource "aws_instance" "terraform_instance" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t2.nano"
  vpc_security_group_ids = ["sg-0d4ecf989cb68563d",aws_security_group.terraform_security_group.id]  #List

}

output "instance_id" {
  value = aws_instance.terraform_instance.id
}

output "security_group_id" {
  value = aws_security_group.terraform_security_group.id
}