# Output the hostnames, domain names, private IP addresses, and public IP addresses of the VMs
output "vm_hostnames" {
  value = [ for vm in azurerm_linux_virtual_machine.vmlinux : vm.computer_name ]
}

output "vm_domain_names" {
    value = values(azurerm_public_ip.vmlinux_public_ip)[*].fqdn
}

output "vmlinux-private-ip" {
    value = values(azurerm_linux_virtual_machine.vmlinux)[*].private_ip_address
}

output "vmlinux-public-ip" {
  value = values(azurerm_linux_virtual_machine.vmlinux)[*].public_ip_address
}

# output "nic_id" {
#     value = values(azurerm_linux_virtual_machine.vmlinux)[*].network_interface_ids[0]
# }

output "n01591501-vmlinux" {
    value = {
        ids = values(azurerm_linux_virtual_machine.vmlinux)[*].id
        nic_ids = values(azurerm_linux_virtual_machine.vmlinux)[*].network_interface_ids[0]
        }
}
