output "loadbalancer_name" {
  value = azurerm_lb.loadbalancer.name
}

output "loadbalancer_fqdn" {
  value = azurerm_public_ip.lb_public_ip.fqdn  
}