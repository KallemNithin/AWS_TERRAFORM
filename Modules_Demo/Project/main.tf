provider "aws" {
  region = "us-east-1"
}

module "key_pair" {
  source = "../Modules/KeyPair"
}

module "security_group" {
  source = "../Modules/SecurityGroup"
}


module "ec2_instance" {
  source = "../Modules/EC2"

  depends_on = [
    module.key_pair
  ]
  vpc_security_group_ids = [
    module.security_group.security_group_id
  ]
  key_name = module.key_pair.key_pair_name
  private_key = module.key_pair.private_key

}