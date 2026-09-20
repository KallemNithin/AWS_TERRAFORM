provider "aws" {
  region = "us-east-1"
}

variable "instance_ami" {
  description = "The type of instance to create"
  type        = map(string)
  default     = {
    "SIT" = "ami-0f8a61b66d1accaee",
    "UAT" = "ami-0fef201115eefe936",
    "PROD" = "ami-0c55b159cbfafe1f",
    "MIG" = "ami-0c55b159cbfafe1f2",
    "DEV"  = "ami-0fef201115eefe936"
  }
}

variable "environment" {
  type        = list(string)
  default     = ["SIT","DEV","UAT"]
}

resource "aws_instance" "testing_server" {
  count         = length(var.environment)
  ami           = lookup(var.instance_ami, var.environment[count.index])  #LOOKUP FUNCTION
  instance_type = "t3.micro"

  tags = {
    Name = "KVN-${var.environment[count.index]}"
    CreationDate = formatdate("DD MM YYYY hh:mm ZZZ", timestamp())
  }
}