locals {
  time = formatdate("YYYYMMDDHHMM", timestamp())
}



source "googlecompute" "server" {
  project_id        = "hc-3e11f67ef1f246e69d147bf00b3"
  source_image_family = "rhel-10"
  source_image = "rhel-10-v20251016"
  machine_type     = "e2-standard-4"
  zone             = "us-east1-b"
  image_name       = "nomad-server-${local.time}"
  ssh_username     = "packer"
}

source "googlecompute" "client" {
  project_id        = "hc-3e11f67ef1f246e69d147bf00b3"
  source_image_family = "rhel-10"
  source_image = "rhel-10-v20251016"
  machine_type     = "e2-standard-4"
  zone             = "us-east1-b"
  image_name       = "nomad-server-${local.time}"
  ssh_username = "packer"
}