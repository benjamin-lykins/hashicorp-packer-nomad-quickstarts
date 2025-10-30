locals {
  time = formatdate("YYYYMMDDHHmmss", timestamp())
}

source "amazon-ebs" "server" {
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.this.id
  instance_type               = var.instance_type
  ssh_username                = var.ssh_username
  ami_name                    = "nomad-server-${local.time}"
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
  associate_public_ip_address = var.associate_public_ip_address
}

source "amazon-ebs" "client" {
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.this.id
  instance_type               = var.instance_type
  ssh_username                = var.ssh_username
  ami_name                    = "nomad-client-${local.time}"
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
  associate_public_ip_address = var.associate_public_ip_address
}
