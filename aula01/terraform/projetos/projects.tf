resource "random_id" "project_suffix" {
  byte_length = 3
}

locals {
  projects = {
    cluster1 = {
      name = "cluster1"
    }

    cluster2 = {
      name = "cluster2"
    }
  }

  use_org    = trimspace(var.org_id) != ""
  use_folder = trimspace(var.folder_id) != ""
}

resource "google_project" "course" {
  for_each = local.projects

  name            = each.value.name
  project_id      = lower("${var.project_prefix}-${each.key}-${random_id.project_suffix.hex}")
  billing_account = var.billing_account_id

  org_id    = local.use_org ? var.org_id : null
  folder_id = local.use_folder ? var.folder_id : null

  # Não cria rede automaticamente nos projetos cluster1 e cluster2.
  # A rede usada pelas VMs do laboratório será a rede default do bootstrap_project_id.
  auto_create_network = false

  # Permite que o Terraform exclua os projetos durante o destroy.
  deletion_policy = "DELETE"

  labels = {
    course = "543"
    tool   = "terraform"
  }
}
