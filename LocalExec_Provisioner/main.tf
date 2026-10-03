provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro" 
}

resource "null_resource" "name" {

    provisioner "local-exec" {
        command = "echo ${aws_instance.ec2.public_ip} > public_ip.txt"
    }
}

output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}