provider "aws" {
  region = "us-east-1"
}

variable "ports_to_open" {
  type    = list(number)
  default = [22, 80, 443, 8080, 3000, 5000]
}

variable "pheripheral_ports" {
  type = map(object({
    port_number = number
    protocol    = string
    cidr_blocks = list(string)
  }))

  default = {
    kafka = {
      port_number = 9092,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }

    redis = {
      port_number = 6379,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }

    oracle = {
      port_number = 1521,
      protocol    = "tcp",
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

resource "aws_security_group" "terraform_security_group" {
  name        = "terraform_security_group"
  description = "Security group for Terraform instance"

  dynamic "ingress" {
    for_each = var.ports_to_open
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "ingress" {
    for_each = var.pheripheral_ports
    content {
      from_port   = ingress.value.port_number
      to_port     = ingress.value.port_number
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}