module "bdd" {
  source = "./modules/bdd"

  vm_id               = var.bdd_vm_id
  vm_name             = var.bdd_vm_name
  ram                 = var.bdd_ram
  cpu                 = var.bdd_cpu
  disk_size           = var.bdd_disk_size
  vm_ip               = var.bdd_vm_ip
  target_node         = var.target_node
  datastore_id        = var.datastore_id
  image_file_id       = var.image_file_id
  reseau              = var.reseau
  vm_gateway          = var.vm_gateway
  vm_user             = var.vm_user
  vm_password         = var.vm_password
  ssh_public_key_path = var.ssh_public_key_path
}

module "app" {
  source = "./modules/app"

  depends_on = [module.bdd]

  vm_id               = var.app_vm_id
  vm_name             = var.app_vm_name
  ram                 = var.app_ram
  cpu                 = var.app_cpu
  disk_size           = var.app_disk_size
  vm_ip               = var.app_vm_ip
  target_node         = var.target_node
  datastore_id        = var.datastore_id
  image_file_id       = var.image_file_id
  reseau              = var.reseau
  vm_gateway          = var.vm_gateway
  vm_user             = var.vm_user
  vm_password         = var.vm_password
  ssh_public_key_path = var.ssh_public_key_path
}


# Génération d'un inventaire Ansible
resource "local_file" "ansible_inventory" {
  content = <<-EOT
    [app]
    ${module.app.ip_address} ansible_user=alaa
    
    [bdd]
    ${module.bdd.ip_address} ansible_user=alaa

    [all:vars]
    db_password=${var.db_password}
  EOT
  filename = "../ansible/inventory.ini"
}

# Exécution automatique du playbook Ansible une fois l'infrastructure prête
resource "null_resource" "run_ansible" {
  depends_on = [
    module.bdd,
    module.app,
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {
    command = "sleep 45 && cd ../ansible && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml"
  }
}