provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh_terraform"
  description = "Allow SSH inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "allow_app_port" {
  security_group_id = aws_security_group.sg.id
  from_port         = var.app_port    #VARIABLE Assigned
  to_port           = var.app_port    #VARIABLE Assigned
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_ip    #VARIABLE Assigned
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg.id
  from_port         = var.ssh_port    #VARIABLE Assigned
  to_port           = var.ssh_port    #VARIABLE Assigned
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_ip    #VARIABLE Assigned
}