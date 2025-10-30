data "amazon-ami" "this" {
  region = var.aws_region
  filters = {
    virtualization-type = "hvm"
    name                = var.image_filter
    root-device-type    = "ebs"

  }
  owners      = var.image_owner
  most_recent = true
}