variable "project_id" {
  default = "my-gcp-project"
}

variable "region" {
  default = "us-east4"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  type = map(string)
  default = {
    "us-east4-a" = "10.0.1.0/24"
    "us-east4-b" = "10.0.2.0/24"
    "us-east4-c" = "10.0.3.0/24"
  }
}
