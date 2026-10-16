terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region = "us-east-1"
}

# Create a S3 bucket
resource "aws_s3_bucket" "tf_test_kvnith_bucket" {
  bucket = "my-tf-test-kvni-bucket-101"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


terraform {
  backend "s3" {
    bucket       = "nithin-terraform-remote-state-2026"
    key          = "my-project/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}
