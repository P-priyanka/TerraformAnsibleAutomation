resource "azurerm_public_ip" "lb_public_ip" {
  name                = "lb-publicip-n01591501"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_lb" "loadbalancer" {
  name                = "lb-n01591501"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "backend-pool-n01591501"
}

resource "azurerm_network_interface_backend_address_pool_association" "vm_pool_association" {
  count                  = 1
  network_interface_id   = var.nic_ids[count.index]
  ip_configuration_name = "vmlinux-ipconfig-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_lb_rule" "lb_rule" {
  name                = "lb-rule-n01591501"
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  protocol            = "Tcp"
  frontend_port       = 80
  backend_port        = 80
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = "probe-n01591501"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}