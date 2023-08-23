module "rgroup-n01591501" {
  source                   = "./rgroup-n01591501"
  resource_group_name      = "n01591501-ResG"
  location                 = "Central India"
}

module "network-n01591501" {
  source                = "./network-n01591501"
  resource_group_name   = module.rgroup-n01591501.resource_group_name
  location              = "Central India"
}

module "vmlinux-n01591501" {
  source                = "./vmlinux-n01591501"
  nb_count              = "2"
  location              = "Central India"
  resource_group_name   = module.rgroup-n01591501.resource_group_name
  vm_dns_labels         = ["vm1", "vm2", "vm3"]
  availability_zones    = ["1", "2", "3"]
  storage_account_name  = module.common-n01591501.storage_account_name
  storage_account_uri   = module.common-n01591501.storage_account-primary_blob_endpoint
  ubuntu_vm_public_key  = "/mnt/c/Users/Admin/.ssh/id_rsa.pub"
  subnet_id             = module.network-n01591501.subnet_name.id
  instance_count = 3
  extensions = [
    {
      name      = "NetworkWatcherAgentLinux"
      publisher = "Microsoft.Azure.NetworkWatcher"
      version   = "1.0"
    },
    {
      name      = "AzureMonitorLinuxAgent"
      publisher = "Microsoft.Azure.Monitor"
      version   = "1.0"
    }
  ]
}


module "vmwindows-n01591501" {
  source                            = "./vmwindows-n01591501"
  resource_group_name               = module.rgroup-n01591501.resource_group_name
  location                          = "Central India"
  availability_set_name             = "n01591501-avs-win"
  dns_label_prefix                  = "Windows_dns_label"
  storage_account_name              = module.common-n01591501.storage_account_name
  boot_diagnostics_container_name   = "windows_container"
  subnet_id                         = module.network-n01591501.subnet_name.id
  storage_account_uri               = module.common-n01591501.storage_account-primary_blob_endpoint
}

module "common-n01591501" {
  source                = "./common-n01591501"
  resource_group_name   = module.rgroup-n01591501.resource_group_name
  workspace_name        = "n01591501-Workspace"         # Set the name for the log analytics workspace
  vault_name            = "n01591501-Vault"             # Set the name for the recovery services vault
  storage_account_name  = "n01591501storageact"        # Set the name for the storage account
  location              = "Central India"               # Set the location for the resources
}

module "datadisk-n01591501" {
  source     = "./datadisk-n01591501"
  disk_count = 4
  disk_size_gb = 10
  location = "Central India"
  resource_group_name = module.rgroup-n01591501.resource_group_name
  vm_names              =  module.vmlinux-n01591501.vm_hostnames
  vm_ids                = module.vmlinux-n01591501.n01591501-vmlinux.ids
  vm_wids               = module.vmwindows-n01591501.n01591501-vmwindows.ids
  vm_wnames             = module.vmwindows-n01591501.n01591501-vmwindows.hostnames
  }


module "database-n01591501" {
  source     = "./database-n01591501"
  location   = "Central India"
  resource_group_name = module.rgroup-n01591501.resource_group_name
}

module "loadbalancer-n01591501" {
  source    = "./loadbalancer-n01591501"
  location  = "Central India"    

  nic_ids = module.vmlinux-n01591501.n01591501-vmlinux.nic_ids
  resource_group_name = module.rgroup-n01591501.resource_group_name
}
