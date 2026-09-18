variable "allowed_ip" {
  default = "10.0.120.36/32"
}

variable "app_port" {
  default = 8080
  type    = number
}

variable "ssh_port" {
  default = 22
  type    = number
}