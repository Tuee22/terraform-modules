
variable "cloud_provider" {
  description = "Cloud provider to use (aws or gcp)"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "gcp_region" {
  description = "GCP region to deploy to"
  type        = string
  default     = "us-central1"
}

variable "gcp_project" {
  description = "GCP project ID"
  type        = string
}

variable "instance_type" {
  description = "Instance type for AWS"
  type        = string
  default     = "t2.micro"
}

variable "machine_type" {
  description = "Machine type for GCP"
  type        = string
  default     = "e2-medium"
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}
