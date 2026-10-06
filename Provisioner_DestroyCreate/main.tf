terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_permissions" {
  name        = "allow_permissions"
  description = "Allow inbound and outbound traffic"

    /*ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }*/

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
}

resource "aws_instance" "example" {
  ami           = var.ami_image
  instance_type = var.instance_type
  key_name      = "teeraform-key"
  security_groups = [aws_security_group.allow_permissions.name]
  vpc_security_group_ids = [aws_security_group.allow_permissions.id]

  provisioner "remote-exec" {
    on_failure = continue
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./teeraform-key.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    on_failure = continue
    when    = destroy
    inline = [
      "sudo systemctl stop nginx",
      "sudo yum remove -y nginx"
    ]
  }
}