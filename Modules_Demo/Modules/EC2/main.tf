/*provider "aws" {
  region = "us-east-1"
}*/

resource "aws_instance" "example" {
  ami           = var.ami_image
  instance_type = var.instance_type
  key_name     = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

    provisioner "remote-exec" {
      inline = [
        "sudo yum update -y",
        "sudo yum install -y httpd",
        "sudo systemctl start httpd", 
        "sudo systemctl enable httpd"
      ]
      connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = var.private_key
      host        = aws_instance.example.public_ip
      }
    }

}