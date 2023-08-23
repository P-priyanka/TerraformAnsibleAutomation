output "child_module_resource_group_name" {
  value = module.rgroup-n01591501.resource_group_name
}

# Output the virtual network and subnet names from the child module
output "humber_vnet_name" {
  value = module.network-n01591501.virtual_network_name
}

output "humber_subnet_name" {
  value = module.network-n01591501.subnet_name
}

# Output the names of the log analytics workspace, recovery services vault, and storage account from the child module
output "humber_workspace_name" {
  value = module.common-n01591501.workspace_name
}

output "humber_vault_name" {
  value = module.common-n01591501.vault_name
}

output "humber_storage_account_name" {
  value = module.common-n01591501.storage_account_name
}

# Output the hostnames, domain names, private IP addresses, and public IP addresses of the VMs from the child module
output "vm_hostnames" {
  value = module.vmlinux-n01591501.vm_hostnames
}

output "vm_domain_names" {
  value = module.vmlinux-n01591501.vm_domain_names
}

output "vm_private_ip_addresses" {
  value = module.vmlinux-n01591501.vmlinux-private-ip
}

output "vm_public_ip_addresses" {
  value = module.vmlinux-n01591501.vmlinux-public-ip
}

#windows
output "vm_hostname" {
  value = module.vmwindows-n01591501.vm_hostname
}

output "vm_domain_name" {
  value = module.vmwindows-n01591501.vm_domain_name
}

output "vm_private_ip" {
  value = module.vmwindows-n01591501.vm_private_ip
}

output "vm_public_ip" {
  value = module.vmwindows-n01591501.vm_public_ip
}

#datadisk
output "datadisk_ids" {
  description = "IDs of the provisioned data disks"
  value       = module.datadisk-n01591501.data_disk_ids
}

output "datadisk_attachments" {
  description = "Data disk attachments"
  value       = module.datadisk-n01591501.data_disk_attachments
}

#database
output "database_name" {
  value = module.database-n01591501.database_name
}

#loadbalancer
output "loadbalancer_name" {
  value = module.loadbalancer-n01591501.loadbalancer_name
}

output "loadbalancer_fqdn" {
  value = module.loadbalancer-n01591501.loadbalancer_fqdn  
}