source "amazon-ebs" "ubuntu-x86" {
  region               = "{{user `region`}}"
  instance_type        = "t3.medium"
  ami_name             = "custom-ubuntu-x86-{{timestamp}}"
  subnet_id            = "{{user `subnet_id`}}"
  security_group_id    = ["{{user `security_group_id`}}"]
  ssh_keypair_name     = "{{user `key_name`}}"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username         = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu-x86"]

  provisioner "shell" {
    script = "../scripts/configure_ubuntu.sh"
  }
}
