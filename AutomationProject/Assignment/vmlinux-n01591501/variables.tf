# Define the child module input variables
locals {
  common_tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name         = "Priyanka.P"
    ExpirationDate = "2024-12-31"
    Environment  = "Project"
  }
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "nb_count" {}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "vm_dns_labels" {
  description = "List of DNS labels for VMs"
  type        = list(string)
}

variable "storage_account_name" {
  description = "Name of the storage account for VM boot diagnostics"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for VM deployment"
  type        = string
}
variable "location" {
  description = "Azure region where the resources should be created"
  type        = string
  default     = "Central India"  
}

variable "ubuntu_vm_public_key" {
  type        = string
  description = "this block is about public key"
}

variable "extensions" {
  description = "List of extensions to install on VMs"
  type        = list(object({
    name      = string
    publisher = string
    version   = string
  }))
}

variable "storage_account_uri" {
  type = string
}

variable "instance_count" {
  type = number
    description = "Total number of Linux VMs"
}