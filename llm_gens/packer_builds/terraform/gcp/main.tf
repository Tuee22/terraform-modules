provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "../modules/vpc/gcp"
  vpc_cidr = var.vpc_cidr
  subnet_vpc_cidrs = var.subnet_vpc_cidrs
  tags = "packer-vpc"
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}
