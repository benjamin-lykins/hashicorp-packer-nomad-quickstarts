locals {
  time = formatdate("YYYYMMDDHHmmss", timestamp())
}




source "googlecompute" "server" {
  project_id        = var.gcp_project_id
  source_image_family = "rhel-10"
  source_image = "rhel-10-v20251016"
  machine_type     = var.machine_type
  zone             = var.zone
  image_name       = "nomad-server-${local.time}"
  ssh_username     = var.ssh_username
}

source "googlecompute" "client" {
  project_id        = var.gcp_project_id
  source_image_family = "rhel-10"
  source_image = "rhel-10-v20251016"
  machine_type     = var.machine_type
  zone             = var.zone
  image_name       = "nomad-client-${local.time}"
  ssh_username = var.ssh_username
}