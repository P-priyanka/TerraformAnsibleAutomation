output "vm_hostname" {
  value = azurerm_windows_virtual_machine.vmwindows[0].name
}

output "vm_domain_name" {
  value = "${azurerm_network_interface.vmwindows_nic[0]}"
}

output "vm_private_ip" {
  value = azurerm_network_interface.vmwindows_nic[0].private_ip_address
}

output "vm_public_ip" {
  value = azurerm_public_ip.vmwindows_public_ip[*].ip_address
}

output "n01591501-vmwindows" {
    value = {
        ids = azurerm_windows_virtual_machine.vmwindows[*].id
        hostnames = azurerm_windows_virtual_machine.vmwindows[*].name
        }
}
