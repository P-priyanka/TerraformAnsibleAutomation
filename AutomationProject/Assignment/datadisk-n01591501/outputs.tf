output "data_disk_ids" {
  description = "IDs of the provisioned data disks"
  value       = azurerm_managed_disk.datadisk[*].id
}

output "data_disk_attachments" {
  description = "Data disk attachments"
  value       = azurerm_virtual_machine_data_disk_attachment.datadisk_attachment[*]
}
