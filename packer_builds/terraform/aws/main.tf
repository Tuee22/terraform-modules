provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc/aws"
  vpc_cidr = var.vpc_cidr
  subnet_vpc_cidrs = var.subnet_vpc_cidrs
  tags = "packer-vpc"
}

output "subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "security_group_id" {
  value = module.vpc.security_group_id
}
