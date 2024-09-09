provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc/aws"
  cidr_block = var.cidr_block
  subnet_cidr_blocks = var.subnet_cidr_blocks
  name = "packer-vpc"
}

output "subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "security_group_id" {
  value = module.vpc.security_group_id
}
