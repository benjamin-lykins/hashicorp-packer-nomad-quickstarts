data "amazon-ami" "this" {
  region = var.aws_region
  filters = {
    virtualization-type = "hvm"
    name                = "RHEL_HA-10.0.0_HVM-*-x86_64-0-Hourly2-GP3"
    root-device-type    = "ebs"

  }
  owners      = ["309956199498"]
  most_recent = true
}

source "amazon-ebs" "this" {
  region                      = var.aws_region
  source_ami                  = data.amazon-ami.rhel_10.id
  instance_type               = "t2.large"
  ssh_username                = "ec2-user"
  ami_name                    = "multi_rhel_10_instana_base_${local.time}"
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
  associate_public_ip_address = var.associate_public_ip_address
}