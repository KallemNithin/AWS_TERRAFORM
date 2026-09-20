provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ami_details" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }
}

resource "aws_instance" "ubuntu_instance" {
  ami           = data.aws_ami.ami_details.id
  instance_type = "t2.nano"

  tags = {
    Name = "UbuntuInstance"
  }
}