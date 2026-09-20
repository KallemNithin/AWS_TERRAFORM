provider "aws" {
  region = "us-east-1"
}

#data "aws_instances" "name" {}

data "aws_instance" "name" {
  filter {
    name   = "tag:Environment"
    values = ["UAT"]
  }
}