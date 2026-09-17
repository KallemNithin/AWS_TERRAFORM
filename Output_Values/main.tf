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

output "instance_id" {
  value = aws_instance.web   #Prints the output related to the resource aws_instance.web
}

output "instance_public_ip" {
  value = aws_instance.web.public_ip   #Prints the output related to the resource aws_instance.web public ip 
}

output "instance_state" {
  value = aws_instance.web.instance_state   #Prints the output related to the resource aws_instance.web instance state
}

output "instance_hostname_url"{
  value = "https://${aws_instance.web.public_ip}:8080"   #Prints the output related to the resource url running on port 8080
}
