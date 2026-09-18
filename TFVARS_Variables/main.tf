provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = var.ami_image
  instance_type = var.instance_type

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