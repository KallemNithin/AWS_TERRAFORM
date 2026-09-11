terraform{
    required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.0"
  }
    }
}

terraform{
    backend "s3"{
        bucket="demo-bynithin-for-statelocking"
        key="terraform.tfstate"
        region="us-east-1"
        use_lockfile="true"
        encrypt="true"
    }
}

provider "aws"{
    region="us-east-1"
}

resource "aws_s3_bucket" "state_locking_demo"{
    bucket="demo-bynithin-for-statelocking"

    tags={
        environment="dev"
        Name="State_lock_example"
    }
}