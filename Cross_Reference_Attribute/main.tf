provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "eip" {
  domain = "vpc"
}

resource "aws_security_group" "sg" {
  name        = "allow_ssh_terraform"
  description = "Allow SSH inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sg.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "${aws_eip.eip.public_ip}/32"    #CROSS RESOURCE ATTRIBUTE REFERENCE and String Interpolation
}