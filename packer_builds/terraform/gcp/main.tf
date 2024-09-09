provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source = "../modules/vpc/gcp"
  cidr_block = var.cidr_block
  subnet_cidr_blocks = var.subnet_cidr_blocks
  name = "packer-vpc"
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}
