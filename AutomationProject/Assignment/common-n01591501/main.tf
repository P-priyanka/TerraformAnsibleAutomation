# Create the log analytics workspace
resource "azurerm_log_analytics_workspace" "humber_workspace" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  tags                = local.common_tags
}

# Create the recovery services vault
resource "azurerm_recovery_services_vault" "humber_vault" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = local.common_tags
}

# Create the storage account
resource "azurerm_storage_account" "humber_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.common_tags
}

