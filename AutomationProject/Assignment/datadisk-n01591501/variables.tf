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

variable "vm_ids" { 
    type = list(string)
}

variable "vm_wids" { 
    type = list(string)
}

variable "location" {
  description = "Azure region where the resources will be deployed"
  type        = string
}

variable "disk_count" {
  description = "Number of disks to provision"
  type        = number
  default     = 4
}

variable "vm_names" {
  type    = list(string)
  description = "List of VM names to which disks will be attached"
}

variable "vm_wnames" {
  type    = list(string)
  description = "List of windows VM names to which disks will be attached"
}

variable "disk_size_gb" {
  type        = number
  description = "Size of each data disk in GB"
  default     = 10
}
