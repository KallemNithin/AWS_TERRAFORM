/*provider "aws" {
  region = "us-east-1"
}*/

resource "aws_security_group" "allow_permissions" {
  name        = "allow_permissions"
  description = "Allow inbound and outbound traffic"

    ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    }

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

output "security_group_id" {
  value = aws_security_group.allow_permissions.id
}