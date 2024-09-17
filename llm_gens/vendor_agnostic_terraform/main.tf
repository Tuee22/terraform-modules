
# Define provider configuration for AWS and GCP
provider "aws" {
  region = var.aws_region
  count  = var.cloud_provider == "aws" ? 1 : 0
}

provider "google" {
  region  = var.gcp_region
  project = var.gcp_project
  count   = var.cloud_provider == "gcp" ? 1 : 0
}

# Call the generic VPC module, passing in the provider-specific implementation
module "vpc" {
  source = "./modules/vpc"

  cloud_provider = var.cloud_provider
  cidr_block     = var.cidr_block
  subnet_cidrs   = var.subnet_cidrs
}

# Call the generic VM module, passing in the appropriate provider implementation
module "vm" {
  source = "./modules/vm"

  cloud_provider  = var.cloud_provider
  vpc_id          = module.vpc.vpc_id
  vm_name         = var.vm_name
  instance_type   = var.instance_type  # For AWS
  machine_type    = var.machine_type   # For GCP
}
