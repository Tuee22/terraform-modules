
resource "google_compute_instance" "this" {
  name         = var.vm_name
  machine_type = var.machine_type
  network_interface {
    network = var.vpc_id
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
}

output "instance_id" {
  value = google_compute_instance.this.id
}
