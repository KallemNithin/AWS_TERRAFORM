/*provider "aws" {
  region = "us-east-1"
}*/

resource "tls_private_key" "key" {
  algorithm = "RSA"
#  rsa_bits  = 4096
}

#Upload the public key to AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "generated_key"
  public_key = tls_private_key.key.public_key_openssh
}

#Save private key to a file in local
resource "local_file" "private_key" {
  content  = tls_private_key.key.private_key_pem
  filename = "../EC2/generated_key.pem"
  file_permission = "0600"
}

output "key_pair_name" {
  value = aws_key_pair.generated_key.key_name
}

output "private_key" {
  value = tls_private_key.key.private_key_pem
}
