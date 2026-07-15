locals {
  project_ids = data.terraform_remote_state.projetos.outputs.project_ids

  cluster_required_apis = [
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "container.googleapis.com",
    "compute.googleapis.com"
  ]

  # Necessária porque firewall, IPs externos e instâncias agora serão criados
  # no projeto padrão informado em bootstrap_project_id.
  bootstrap_required_apis = [
    "compute.googleapis.com"
  ]

  cluster_project_api_pairs = flatten([
    for project_key, project_id in local.project_ids : [
      for api in local.cluster_required_apis : {
        key        = "${project_key}-${replace(api, ".", "-")}"
        project_id = project_id
        api        = api
      }
    ]
  ])
}

resource "google_project_service" "cluster_required" {
  for_each = {
    for item in local.cluster_project_api_pairs :
    item.key => item
  }

  project = each.value.project_id
  service = each.value.api

  disable_on_destroy = false
}

resource "google_project_service" "bootstrap_required" {
  for_each = toset(local.bootstrap_required_apis)

  project = var.bootstrap_project_id
  service = each.value

  disable_on_destroy = false
}
