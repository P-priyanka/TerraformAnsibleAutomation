locals {
  common_tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name         = "Priyanka.P"
    ExpirationDate = "2024-12-31"
    Environment  = "Learning"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the resources will be deployed"
  type        = string
}

variable "availability_set_name" {
  description = "Name of the availability set"
  type        = string
}

variable "dns_label_prefix" {
  description = "Prefix for the DNS label assigned to the VM"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account used for boot diagnostics"
}

variable "boot_diagnostics_container_name" {
  description = "Name of the boot diagnostics container"
  type        = string
}

variable "admin_username" {
  description = "Username for the administrator of the VM"
  default = "priyanka_n01591501"
  type        = string
}

variable "admin_password" {
  description = "Password for the administrator of the VM"
  type        = string
  default = "humber@1501"
}

variable "subnet_id" {
  description = "ID of the subnet for VM deployment"
  type        = string
}

variable "storage_account_uri" {
  
}