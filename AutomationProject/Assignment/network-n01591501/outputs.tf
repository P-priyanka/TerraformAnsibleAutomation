
output "virtual_network_name" {
  value = azurerm_virtual_network.humber_vnet.name
}

output "subnet_name" {
  value = azurerm_subnet.humber_subnet
  #description = azurerm_subnet.humber_subnet.name
}