output "instances" {
  description = "Informações principais das instâncias criadas."
  value = {
    for key, instance in google_compute_instance.vm :
    key => {
      name         = instance.name
      project      = instance.project
      zone         = instance.zone
      machine_type = instance.machine_type
      nat_ip       = data.terraform_remote_state.rede.outputs.external_ips[key]
      tags         = instance.tags
    }
  }
}

output "ssh_commands" {
  description = "Comandos para acessar as instâncias via gcloud compute ssh."
  value = {
    for key, instance in google_compute_instance.vm :
    key => "gcloud compute ssh ${instance.name} --zone ${var.zone} --project ${var.bootstrap_project_id}"
  }
}

output "rancher_url" {
  description = "URL sugerida para acesso futuro ao Rancher."
  value       = "https://${data.terraform_remote_state.rede.outputs.external_ips["rancher"]}"
}

output "nfs_validation_commands" {
  description = "Comandos para validar o NFS após acessar a instância nfs-server."
  value = [
    "showmount -e localhost",
    "systemctl status nfs-kernel-server --no-pager",
    "cat /etc/exports"
  ]
}
