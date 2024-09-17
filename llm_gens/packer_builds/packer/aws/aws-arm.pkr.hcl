source "amazon-ebs" "ubuntu-arm" {
  region               = "{{user `region`}}"
  instance_type        = "t4g.medium"
  ami_name             = "custom-ubuntu-arm-{{timestamp}}"
  subnet_id            = "{{user `subnet_id`}}"
  security_group_id    = ["{{user `security_group_id`}}"]
  ssh_keypair_name     = "{{user `key_name`}}"
  
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username         = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu-arm"]

  provisioner "shell" {
    script = "../scripts/configure_ubuntu.sh"
  }
}
