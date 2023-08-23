# Output the names of the log analytics workspace, recovery services vault, and storage account
output "workspace_name" {
  value = azurerm_log_analytics_workspace.humber_workspace.name
}

output "vault_name" {
  value = azurerm_recovery_services_vault.humber_vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.humber_storage.name
}

output "storage_account-primary_blob_endpoint" {
  value = azurerm_storage_account.humber_storage.primary_blob_endpoint
}