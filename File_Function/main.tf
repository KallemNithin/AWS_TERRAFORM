provider "aws" {
  region = "us-east-1"
}   

variable "iam_user_name" {
  description = "The name of the IAM user"
  type        = string
  default     = "kafka_user"
}

resource "aws_iam_user" "kafka_user" {
  name = "kafka_user"
}


resource "aws_iam_user_policy" "kafka_user_policy" {
  name = "kafka_user_policy"
  user = aws_iam_user.kafka_user.name

  policy = var.iam_user_name == aws_iam_user.kafka_user.name ? file("./kafka_user_policy.json") : file("./rds_user_policy.json")  #FILE FUNCTION
  
}