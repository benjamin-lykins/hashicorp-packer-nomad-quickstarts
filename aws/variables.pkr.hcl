variable "aws_region" {
  type        = string
  description = "The AWS region to create resources in"
  default     = "us-east-2"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to launch the instance in"
}

variable "subnet_id" {
  type        = string
  description = "The VPC Subnet ID to launch the instance in"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with the instance"
  default     = true
}

variable "ssh_username" {
  type        = string
  description = "The SSH username for connecting to the instances."
  default     = "ec2-user"
}

variable "instance_type" {
  type        = string
  description = "The instance type for the AWS instances."
  default     = "t2.large"
}

variable "image_filter" {
  type        = string
  description = "The name of the AMI to use for the instances."
  default     = "RHEL_HA-10.0.0_HVM-*-x86_64-0-Hourly2-GP3"
}

variable "image_owner" {
  type        = list(string)
  description = "The owner ID of the AMI to use for the instances."
  default     = ["309956199498"]
}

// Build Variables

variable "provision_vault" {
  type        = bool
  description = "Whether to provision Vault on the instance."
  default     = false
}