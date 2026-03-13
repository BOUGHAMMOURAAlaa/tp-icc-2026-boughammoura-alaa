# Variables de configuration de la VM APP
variable "vm_name" { type = string }
variable "ram" { type = number }
variable "cpu" { type = number }
variable "disk_size" { type = number }
variable "vm_ip" { type = string }

variable "target_node" { type = string }
variable "datastore_id" { type = string }
variable "image_file_id" { type = string }
variable "reseau" { type = string }
variable "vm_gateway" { type = string }
variable "vm_user" { type = string }
variable "vm_password" { type = string }
variable "ssh_public_key_path" { type = string }
variable "vm_id" { type = number }