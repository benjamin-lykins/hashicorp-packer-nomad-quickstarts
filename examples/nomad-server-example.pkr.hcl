# Example Packer template for building Nomad server images
# This can be adapted for AWS, Azure, GCP, or other providers

packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

# Variables
variable "nomad_version" {
  type    = string
  default = "1.8.4"
}

variable "nomad_node_role" {
  type    = string
  default = "server"
  description = "server, client, or both"
}

variable "nomad_datacenter" {
  type    = string
  default = "dc1"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "source_ami_filter" {
  type    = string
  default = "RHEL-9*"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

# Data source to find the latest RHEL AMI
data "amazon-ami" "rhel" {
  filters = {
    name                = var.source_ami_filter
    virtualization-type = "hvm"
    root-device-type    = "ebs"
    architecture        = "x86_64"
  }
  owners      = ["309956199498"] # Red Hat
  most_recent = true
  region      = var.aws_region
}

# Build configuration
source "amazon-ebs" "nomad" {
  ami_name      = "nomad-${var.nomad_node_role}-${var.nomad_version}-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.aws_region
  source_ami    = data.amazon-ami.rhel.id
  
  ssh_username = "ec2-user"
  
  tags = {
    Name          = "nomad-${var.nomad_node_role}"
    OS            = "RHEL"
    NomadVersion  = var.nomad_version
    NomadRole     = var.nomad_node_role
    BuildDate     = "{{timestamp}}"
    BuildTool     = "Packer"
  }
  
  run_tags = {
    Name = "packer-nomad-builder"
  }
}

build {
  name = "nomad-image"
  
  sources = [
    "source.amazon-ebs.nomad"
  ]
  
  # Update system packages
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y python3"
    ]
  }
  
  # Install and configure Nomad using Ansible
  provisioner "ansible" {
    playbook_file = "../ansible/nomad-server.yml"
    extra_arguments = [
      "-e", "nomad_version=${var.nomad_version}",
      "-e", "nomad_node_role=${var.nomad_node_role}",
      "-e", "nomad_datacenter=${var.nomad_datacenter}",
      "--extra-vars", "ansible_python_interpreter=/usr/bin/python3"
    ]
  }
  
  # Cleanup
  provisioner "shell" {
    inline = [
      "sudo yum clean all",
      "sudo rm -rf /tmp/*",
      "sudo rm -rf /var/tmp/*"
    ]
  }
  
}
