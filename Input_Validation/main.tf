provider "aws" {
  region = "us-east-1"
}

variable "db_username" {
    type = string
    description = "The username for the database"

    validation {
        condition     = length(var.db_username) >= 5
        error_message = "The database username must be at least 5 characters long."
    }
}