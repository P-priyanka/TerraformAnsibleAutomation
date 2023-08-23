resource "null_resource" "vmlinux-n01591501-provisioner" {
    for_each = local.instances

    triggers = {
    always_run = timestamp()
  }
    # provisioner "remote-exec" {
    #     inline = [ "echo Hostname: $(hostname)" ]
    # }
    provisioner "local-exec" {
    command = "ansible-playbook -e 'target_ip=${each.value.network_interface_ids[0]}' N01591501-playbook.yml"
    working_dir = path.module
  }
    connection {
      type = "ssh"
      user = "priyanka_n01591501"
      host = azurerm_linux_virtual_machine.vmlinux[each.key].public_ip_address
      private_key = file("C:\\Users\\Admin\\.ssh\\id_rsa")
    }

    depends_on = [ azurerm_linux_virtual_machine.vmlinux ]
}