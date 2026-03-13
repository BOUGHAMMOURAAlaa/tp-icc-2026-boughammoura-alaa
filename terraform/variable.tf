# Variables communes à toutes les VMs
variable "target_node" { type = string }
variable "datastore_id" { type = string }
variable "image_file_id" { type = string }
variable "reseau" { type = string }
variable "vm_gateway" { type = string }
variable "vm_user" { type = string }
variable "vm_password" { type = string }
variable "ssh_public_key_path" { type = string }

# Variables spécifiques à la VM BDD
variable "bdd_vm_name" { type = string }
variable "bdd_ram" { type = number }
variable "bdd_cpu" { type = number }
variable "bdd_disk_size" { type = number }
variable "bdd_vm_ip" { type = string }

# Variables spécifiques à la VM App
variable "app_vm_name" { type = string }
variable "app_ram" { type = number }
variable "app_cpu" { type = number }
variable "app_disk_size" { type = number }
variable "app_vm_ip" { type = string }

variable "bdd_vm_id" { type = number }
variable "app_vm_id" { type = number }

variable "db_password" {
  description = "Mot de passe de la base de données PostgreSQL"
  type        = string
  sensitive   = true 
}