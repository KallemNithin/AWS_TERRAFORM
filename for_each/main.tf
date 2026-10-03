provider "aws" {
  region = "us-east-1"
}

variable "iam_users" {
    type = set(string)
    default = ["user1", "user2", "user3"]

}

variable "ec2_instances" {
    type = map(string)
    default = {
        "dev" = "ami-0d27e0fb3bac4d724",
        "prod" = "ami-0d27e0fb3bac4d724",
        "mig" = "ami-0d27e0fb3bac4d724"
    }
}

resource "aws_iam_user" "example" {
    for_each = var.iam_users
    name = each.value
}

resource "aws_instance" "example" {
    for_each = var.ec2_instances
    ami = each.value
    instance_type = "t2.micro"

    tags = {
        Name = each.key
    }
}