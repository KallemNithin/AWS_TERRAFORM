provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "3.0.0"
    }
  }
}

variable "ports" {
  type    = list(number)
  default = [22, 80]
}

#Generate RSA public and private key pair
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Upload the public key to AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.key.public_key_openssh
}

#Save private key to a file in local
resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "./generated_key.pem"
  file_permission = "0600"
}

resource "aws_security_group" "allow_permissions" {
    name        = "allow_permissions"
    description = "Allow inbound and outboundtraffic"

    dynamic "ingress" {
      for_each = var.ports

    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "name" {
    ami           = "ami-0d27e0fb3bac4d724"
    instance_type = "t2.micro" 
    key_name      = aws_key_pair.generated_key.key_name
    vpc_security_group_ids = [
         aws_security_group.allow_permissions.id
    ]
    connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = tls_private_key.key.private_key_pem
        host        = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y httpd",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd"
        ]
    }
}