provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
#  ami           = "ami-0b6d9d3d33ba97d99"
  ami           = "ami-0d27e0fb3bac4d724" 
  instance_type = "t2.micro"

/*lifecycle {
    prevent_destroy = true
  }*/
}


