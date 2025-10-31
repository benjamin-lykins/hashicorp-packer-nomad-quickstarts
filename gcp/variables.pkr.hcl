variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID where resources will be created."
}

variable "machine_type" {
  type        = string
  description = "The machine type for the GCP instances."
  default     = "e2-standard-4"
}

variable "zone" {
  type        = string
  description = "The GCP zone where instances will be created."
  default     = "us-east1-b"
}

variable "ssh_username" {
  type        = string
  description = "The SSH username for connecting to the instances."
  default     = "packer"
}

variable "image_family" {
  type        = string
  description = "The image family to use for the instances."
  default     = "rhel-10"
}

variable "gcp_image_project_id" {
  type        = string
  description = "The GCP project ID where the image family is located."
  default     = "rhel-cloud"
}

variable "cpu_architecture" {
  type        = string
  description = "The CPU architecture for the image."
  default     = "X86_64"
}