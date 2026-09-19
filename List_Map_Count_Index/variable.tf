variable "region" {
  description = "The AWS region to deploy resources in"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1"]
  
}

variable "user_name" {
  description = "The name of the IAM user to create"
  type        = list(string)
  default     = ["jenkins.user", "kafka.user", "redis.user"]
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = map(string)
  default     = {
    "0" = "t2.micro"
    "1" = "t2.small"
    "2" = "t2.medium"
  }
}