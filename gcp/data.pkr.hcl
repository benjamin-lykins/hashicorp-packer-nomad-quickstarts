data "googlecompute-image" "this" {
  project_id = var.gcp_image_project_id
  filters = "family=${var.image_family} AND architecture=${var.cpu_architecture}"
  most_recent = true
}
