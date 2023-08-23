locals {
  common_tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name         = "Priyanka.P"
    ExpirationDate = "2024-12-31"
    Environment  = "Learning"
  }
}

variable "location" {
  description = "Azure region where the resource group should be created"
  type        = string
  default     = "Central India"
}

# Define the child module input variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "n01591501-RG"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "n01591501-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "n01591501-subnet"
}
