resource "azurerm_windows_virtual_machine" "vmwindows" {
  count                = 1
  name                 = "windows-vm-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  size                 = "Standard_DS2_v2"
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  tags = local.common_tags

  os_disk {
    name              = "osdisk-${count.index}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  network_interface_ids = [azurerm_network_interface.vmwindows_nic[count.index].id]

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

}

resource "azurerm_public_ip" "vmwindows_public_ip" {
  count                = 1
  name                 = "publicip-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  allocation_method    = "Static"
  sku                  = "Standard"
  tags = local.common_tags
}

resource "azurerm_network_interface" "vmwindows_nic" {
  count                = 1
  name                 = "vmwindows-nic-${count.index}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  tags = local.common_tags

  ip_configuration {
    name                          = "ipconfig-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create the availability set
resource "azurerm_availability_set" "availability_set" {
  name                = "1501-windows-availability-set"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count   = 1
  platform_update_domain_count = 1
  tags = local.common_tags
}

resource "azurerm_virtual_machine_extension" "n01591501-vmwindows-antimalware" {
  count = 1
  name = "1501-windows-antimalware-${format("%d", count.index+1)}"
  publisher = "Microsoft.Azure.Security"
  type = "IaaSAntimalware"
  type_handler_version = "1.4"
  auto_upgrade_minor_version = "true"
  virtual_machine_id = element(azurerm_windows_virtual_machine.vmwindows[*].id, count.index)

  settings = <<SETTINGS
        {
            "AntimalwareEnabled": true,
            "RealtimeProtectionEnabled": "true",
            "ScheduledScanSettings": {
                "isEnabled": "true",
                "day": "1",
                "time": "120",
                "scanType": "Quick"
                },
            "Exclusions": {
                "Extensions": "",
                "Paths": "",
                "Processes": ""
                }
        }
    SETTINGS

    tags = local.common_tags
}