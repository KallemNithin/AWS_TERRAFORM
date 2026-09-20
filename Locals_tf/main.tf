provider "aws" {
  region = "us-east-1"
}

variable "tags" {
  type        = map(string)
  default     = {
    name = "TerraformExample"
    ##CreationDate = formatdate("DD MM YYYY hh:mm ZZZ", timestamp()) cannot be set under variables
  }
}

locals {
  default_tags = {
    Name = "TerraformExample"
    CreationDate = formatdate("DD MM YYYY hh:mm ZZZ", timestamp())
  }
}

resource "aws_security_group" "terraform_security_group" {
  name        = "terraform_security_group"
  tags        = local.default_tags
}