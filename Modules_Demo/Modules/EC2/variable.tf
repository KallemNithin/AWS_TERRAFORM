variable "ami_image" {
  default = "ami-0d27e0fb3bac4d724"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "private_key" {
  type = string 
}