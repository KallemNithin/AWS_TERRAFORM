provider "aws" {
  region = "us-east-1"
}

variable "instance_type" {
}

data "aws_ec2_instance_type" "selected" {
  instance_type = var.instance_type
}

resource "aws_instance" "example" {
  ami           = "ami-0d27e0fb3bac4d724"
  instance_type = var.instance_type

  lifecycle {
    precondition {
      condition     = data.aws_ec2_instance_type.selected.free_tier_eligible == true
      error_message = "The selected instance type is not eligible for the free tier."
    
    }

    postcondition {
      condition     = self.public_ip != null
      error_message = "The instance failed to start."
    }
  }
}