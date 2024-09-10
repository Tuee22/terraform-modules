
resource "google_compute_network" "this" {
  name                    = "gcp-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  for_each   = toset(var.subnet_cidrs)
  network    = google_compute_network.this.id
  ip_cidr_range = each.value
}

output "network_id" {
  value = google_compute_network.this.id
}
