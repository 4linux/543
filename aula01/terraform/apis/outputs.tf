output "project_ids" {
  description = "IDs dos projetos lidos da etapa projetos."
  value       = data.terraform_remote_state.projetos.outputs.project_ids
}

output "enabled_cluster_apis" {
  description = "APIs gerenciadas pelo Terraform nos projetos cluster1 e cluster2."
  value = {
    for key, api in google_project_service.cluster_required :
    key => api.service
  }
}

output "enabled_bootstrap_apis" {
  description = "APIs gerenciadas pelo Terraform no projeto padrão/bootstrap."
  value = {
    for key, api in google_project_service.bootstrap_required :
    key => api.service
  }
}

output "enabled_apis" {
  description = "Todas as APIs gerenciadas pelo Terraform nesta etapa."
  value = merge(
    {
      for key, api in google_project_service.cluster_required :
      key => api.service
    },
    {
      for key, api in google_project_service.bootstrap_required :
      "bootstrap-${key}" => api.service
    }
  )
}
