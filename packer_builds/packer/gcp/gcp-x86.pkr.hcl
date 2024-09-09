source "googlecompute" "ubuntu-x86" {
  project_id       = "{{user `project_id`}}"
  zone             = "{{user `zone`}}"
  machine_type     = "e2-standard-2"
  ssh_username     = "ubuntu"
  ssh_private_key_file = "{{user `private_key_file`}}"

  source_image_family  = "ubuntu-2204-lts"
  source_image_project = "ubuntu-os-cloud"
}

build {
  sources = ["source.googlecompute.ubuntu-x86"]

  provisioner "shell" {
    script = "../scripts/configure_ubuntu.sh"
  }
}
