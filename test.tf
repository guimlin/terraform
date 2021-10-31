terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "node" {
  count     = 1
  name      = format("node_new-%02d", count.index + 1)
  
  
  image     = "https://app.vagrantup.com/ubuntu/boxes/jammy64/versions/20211025.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "5 gib"
  user_data = file("${path.module}/user_data")



  network_adapter {
    type           = "bridged"
    host_interface = "Realtek PCIe GBE Family Controller"
  }

/*
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/tmp111",     
    ]
  }
  */
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}