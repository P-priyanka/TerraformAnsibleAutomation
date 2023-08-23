locals {
  instances = {
    for instance in range(0, "${var.instance_count}") :
        "${instance}" => "vmlinux-${instance}"
  }
}

# Create the network interface for the virtual machines
resource "azurerm_network_interface" "vmlinux_nic" {
  for_each            = { for idx, dns_label in var.vm_dns_labels : idx => dns_label }
  name                = "vmlinux-nic-${each.value}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                =  local.common_tags
  ip_configuration {
    name                          = "vmlinux-ipconfig-${each.key}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vmlinux_public_ip[each.key].id
  }
}

# Create the CentOS Linux VMs
resource "azurerm_linux_virtual_machine" "vmlinux" {
  for_each                = { for idx, dns_label in var.vm_dns_labels : idx => dns_label }
  name                    = "centos-${each.value}"
  computer_name           = "centos-${each.value}"
  location                = var.location
  resource_group_name     = var.resource_group_name
  size                    = "Standard_D2s_v3"
  admin_username          = "priyanka_n01591501"
  admin_password          = "humber@1501"  
  disable_password_authentication = false
  tags = local.common_tags

  admin_ssh_key {
    username   = "priyanka_n01591501"
    public_key = file(var.ubuntu_vm_public_key)
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  network_interface_ids = [azurerm_network_interface.vmlinux_nic[each.key].id]

  os_disk {
    name                 = "centos-${each.value}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  availability_set_id = azurerm_availability_set.availability_set.id

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

resource "azurerm_virtual_machine_extension" "extensions-networkwatcher" {
  for_each            = azurerm_linux_virtual_machine.vmlinux
  name                = "NetworkWatcherAgentLinux-${each.value.computer_name}"
  virtual_machine_id  = each.value.id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  auto_upgrade_minor_version = true
  tags                       = local.common_tags

  settings = <<SETTINGS
{
  "publisher": "Microsoft.Azure.NetworkWatcher",
  "type": "NetworkWatcherAgentLinux",
  "typeHandlerVersion": "1.4"
}
SETTINGS
}

resource "azurerm_virtual_machine_extension" "extensions-azuremonitor" {
  for_each                   = azurerm_linux_virtual_machine.vmlinux
  name                       = "AzureMonitorExtension-${each.value.computer_name}"
  virtual_machine_id         = each.value.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.common_tags

  settings = <<SETTINGS
{
  "publisher": "Microsoft.Azure.Monitor",
  "type": "AzureMonitorLinuxAgent",
  "typeHandlerVersion": "1.0"
}
SETTINGS
}

# Create the public IP addresses
resource "azurerm_public_ip" "vmlinux_public_ip" {
  for_each            = { for idx, dns_label in var.vm_dns_labels : idx => dns_label }
  name                = "publicip-${each.value}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "domain-centos-${each.value}"
  tags = local.common_tags
}

# Create the availability set
resource "azurerm_availability_set" "availability_set" {
  name                = "1501-linux-availability-set"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count   = "2"
  platform_update_domain_count = "4"
  tags = local.common_tags
}
