
variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of subnet CIDRs"
  type        = list(string)
}
