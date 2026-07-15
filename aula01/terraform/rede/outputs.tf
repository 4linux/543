output "project_ids" {
  description = "IDs dos projetos cluster1 e cluster2 lidos da etapa projetos."
  value       = local.project_ids
}

output "target_project_id" {
  description = "Projeto onde firewall e IPs externos foram configurados."
  value       = var.bootstrap_project_id
}

output "network_name" {
  description = "Nome da rede default usada."
  value       = data.google_compute_network.default.name
}

output "network_self_link" {
  description = "Self link da rede default usada."
  value       = data.google_compute_network.default.self_link
}

output "network_names" {
  description = "Mapa de redes usado para compatibilidade com aulas anteriores."
  value = {
    bootstrap = data.google_compute_network.default.name
  }
}

output "network_self_links" {
  description = "Mapa de self links de rede usado para compatibilidade com aulas anteriores."
  value = {
    bootstrap = data.google_compute_network.default.self_link
  }
}

output "external_ips" {
  description = "IPs externos reservados no projeto padrão/bootstrap."
  value = {
    for key, address in google_compute_address.static :
    key => address.address
  }
}

output "rancher_ip" {
  description = "IP externo da instância rancher."
  value       = google_compute_address.static["rancher"].address
}

output "nfs_server_ip" {
  description = "IP externo da instância nfs-server."
  value       = google_compute_address.static["nfs-server"].address
}

output "custom_ip" {
  description = "IP externo da instância custom."
  value       = google_compute_address.static["custom"].address
}
