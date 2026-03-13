output "ip_bdd" {
  value       = module.bdd.ip_address
  description = "Adresse IP de la machine BDD"
}

output "ip_app" {
  value       = module.app.ip_address
  description = "Adresse IP de la machine APP"
}