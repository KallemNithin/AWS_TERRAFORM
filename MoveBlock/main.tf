provider "aws" {
  region = "us-east-1"
}
resource "aws_security_group" "devenv_Kakfa_sg" {
  name        = "Kakfa_sg"
  description = "Security group for Kafka"
}

moved {
     from = aws_security_group.Kakfa_sg
     to   = aws_security_group.devenv_Kakfa_sg
    }


