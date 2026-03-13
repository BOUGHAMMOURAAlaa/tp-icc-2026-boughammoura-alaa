# Déclaration du provider Terraform
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.98.1"
    }
  }
}

# Configuration du provider Proxmox
provider "proxmox" {
  endpoint = "https://192.168.100.100:8006/"
  username = "alla@pam"
  password = "yi87OA7f"
  insecure = true
}