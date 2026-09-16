provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = "t2.nano"

  tags = {
    Name = "TerraformExample"
  }
}

resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id    #CROSS RESOURCE ATTRIBUTE REFERENCE
  tags = {
    Name = "Web_EIP"
  }
}