
variable "vpc_id" {
  description = "VPC ID to deploy the VM into"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "instance_type" {
  description = "Instance type for AWS"
  type        = string
}

variable "machine_type" {
  description = "Machine type for GCP"
  type        = string
}
