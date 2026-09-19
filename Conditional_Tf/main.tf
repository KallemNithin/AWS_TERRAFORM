provider "aws" {
  region = "us-east-1"
}

variable "iam_user_name" {
  type        = list(string)
  default     = ["jenkins.user", "kafka.user", "redis.user"]
}

variable "environment" {
  type        = list(string)
  default     = ["SIT", "UAT", "PROD"]
}

resource "aws_iam_user" "onboarding_user" {
  name = var.iam_user_name["1"]
}

resource "aws_instance" "kafka_server_dev" {
  ami           = "ami-0354c98ae10b02961"
  instance_type = var.environment == var.environment["0"] && aws_iam_user.onboarding_user.name == "jenkins.user" ? "t2.micro" : "t2.small"

    tags = {
        Name = "Kafka_Server_Dev"
        User = aws_iam_user.onboarding_user.name
        } 
}

output "instance_id" {
  value = aws_instance.kafka_server_dev.instance_type
}