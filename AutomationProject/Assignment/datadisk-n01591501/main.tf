resource "azurerm_managed_disk" "datadisk" {
  count                = length(var.vm_ids)
  name                 = "${var.vm_names[count.index]}-datadisk${format("%1d", count.index + 1)}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "datadisk_attachment" {
  count                = length(var.vm_ids)
  managed_disk_id      = azurerm_managed_disk.datadisk[count.index].id
  virtual_machine_id   = var.vm_ids[count.index]
  lun                  = 0
  caching              = "ReadWrite"
  
  depends_on = [azurerm_managed_disk.datadisk]
}

#Windows
resource "azurerm_managed_disk" "n01591501-vmwindows-datadisk" {
    count                = length(var.vm_wnames)
    name                 = "${var.vm_wnames[count.index]}-win-datadisk${format("%1d", count.index + 1)}"
    location             = var.location
    resource_group_name  = var.resource_group_name
    storage_account_type = "Standard_LRS"
    create_option        = "Empty"
    disk_size_gb         = 10
    tags                 = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01591501-vmwindows-datadisk-attachment" {
    count                = length(var.vm_wnames)
    managed_disk_id      = azurerm_managed_disk.n01591501-vmwindows-datadisk[count.index].id 
    virtual_machine_id   = var.vm_wids[count.index]
    lun                  = 0
    caching              = "ReadWrite"
    depends_on           = [azurerm_managed_disk.n01591501-vmwindows-datadisk]
}
