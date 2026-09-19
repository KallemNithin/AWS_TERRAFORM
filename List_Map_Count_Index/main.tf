provider "aws" {
  region = var.region[0]
}

resource "aws_iam_user" "onboarding_user" {
  name = var.user_name[count.index]
  count = 3
}

resource "aws_instance" "worker_node" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = var.instance_type["1"]
  count         = 3

  tags = {
    Name = "Worker_Node_${count.index}"
  }
}