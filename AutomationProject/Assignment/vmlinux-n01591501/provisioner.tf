resource "null_resource" "vmlinux-n01591501-provisioner" {
    for_each = local.instances

    # provisioner "remote-exec" {
    #     inline = [ "echo Hostname: $(hostname)" ]
    # }
    
    provisioner "local-exec" {
    command = "ansible-playbook -i /mnt/c/Users/Admin/automation/ansible/FinalProject/AutomationProject/hosts /mnt/c/Users/Admin/automation/ansible/FinalProject/AutomationProject/N01591501-playbook.yml"
  }
    connection {
      type = "ssh"
      user = "priyanka_n01591501"
      host = azurerm_linux_virtual_machine.vmlinux[each.key].public_ip_address
      private_key = file("/mnt/c/Users/Admin/.ssh/id_rsa")
    }

    depends_on = [ azurerm_linux_virtual_machine.vmlinux ]
}