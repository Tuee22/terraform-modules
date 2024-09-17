
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_ssh" {
  description = "Flag to enable or disable SSH access."
  type        = bool
  default     = false
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

resource "google_compute_network" "this" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  count       = length(var.public_subnet_cidrs)
  name        = "public-subnet-${count.index}"
  ip_cidr_range = var.public_subnet_cidrs[count.index]
  network     = google_compute_network.this.id
}

resource "google_compute_subnetwork" "private" {
  count       = length(var.private_subnet_cidrs)
  name        = "private-subnet-${count.index}"
  ip_cidr_range = var.private_subnet_cidrs[count.index]
  network     = google_compute_network.this.id
}

resource "google_compute_firewall" "ssh" {
  count = var.enable_ssh ? 1 : 0

  network    = google_compute_network.this.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

output "vpc_id" {
  value = google_compute_network.this.id
}

output "public_subnet_ids" {
  value = google_compute_subnetwork.public[*].id
}

output "private_subnet_ids" {
  value = google_compute_subnetwork.private[*].id
}
