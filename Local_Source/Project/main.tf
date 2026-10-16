provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "git::https://github.com/KallemNithin/AWS_TERRAFORM.git//EC2_Instance"
}
