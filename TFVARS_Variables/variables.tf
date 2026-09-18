variable "region" {
  description = "Instance creation happens in this region"
}

variable "ami_image" {
  description = "AMI image to use for the instance"
}

variable "instance_type" {
  description = "Type of instance to create"
}