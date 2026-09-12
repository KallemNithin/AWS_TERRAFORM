provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terraform_example" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}