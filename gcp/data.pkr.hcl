data "googlecompute-image" "this" {
  project_id = "rhel-cloud"
  filters = "family=${var.image_family} AND architecture=X86_64"
  most_recent = true
}
