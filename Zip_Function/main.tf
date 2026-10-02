provider "aws" {
  region = "us-east-1"
}

variable "user_name" {
  type    = list(string)
  default = ["DEV", "QA", "STG", "PROD"]
}

resource "aws_iam_user" "User_Onboarding" {
  name = var.user_name[count.index]
  count = length(var.user_name)
}

output "user_name" {
  value = aws_iam_user.User_Onboarding[*].name
}
output "user_arn" {
  value = aws_iam_user.User_Onboarding[*].arn
}

output "combination" {
    value = zipmap(aws_iam_user.User_Onboarding[*].name, aws_iam_user.User_Onboarding[*].arn)
}
