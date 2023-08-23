# Define the child module input variables
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
  description = "Azure region where the resources should be created"
  type        = string
  default     = "eastus"  # Update with your desired region
}

variable "workspace_name" {
  description = "Name of the log analytics workspace"
  type        = string
}

variable "vault_name" {
  description = "Name of the recovery services vault"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}
