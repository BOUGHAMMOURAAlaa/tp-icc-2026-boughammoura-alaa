# Module "bdd" : déploie une VM Ubuntu sur Proxmox pour héberger la base de données
resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  vm_id     = var.vm_id
  name      = var.vm_name
  node_name = var.target_node

  cpu {
    cores = var.cpu
  }

  memory {
    dedicated = var.ram
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = var.image_file_id
    interface    = "virtio0"
    size         = var.disk_size
  }

  network_device {
    bridge = var.reseau
  }
  # Initialisation de la VM
  initialization {
    ip_config {
      ipv4 {
        address = var.vm_ip
        gateway = var.vm_gateway
      }
    }
    # Création du compte utilisateur initial
    user_account {
      username = var.vm_user
      password = var.vm_password
      keys     = [trimspace(file(var.ssh_public_key_path))]
    }
  }
}