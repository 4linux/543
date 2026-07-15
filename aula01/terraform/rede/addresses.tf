locals {
  static_ip_names = toset([
    "rancher",
    "nfs-server",
    "custom"
  ])
}

resource "google_compute_address" "static" {
  for_each = local.static_ip_names

  name    = each.key
  project = var.bootstrap_project_id
  region  = var.region

  depends_on = [
    data.terraform_remote_state.apis
  ]
}
