locals {
  project_ids        = data.terraform_remote_state.projetos.outputs.project_ids
  network_project_id = var.bootstrap_project_id
}

data "google_compute_network" "default" {
  name    = "default"
  project = local.network_project_id

  depends_on = [
    data.terraform_remote_state.apis
  ]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  project = local.network_project_id
  network = data.google_compute_network.default.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.allowed_source_ranges
}

resource "google_compute_firewall" "allow_nodeports" {
  name    = "nodeports"
  project = local.network_project_id
  network = data.google_compute_network.default.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = var.allowed_source_ranges
}

resource "google_compute_firewall" "allow_rancher_http_https" {
  name    = "rancher-http-https"
  project = local.network_project_id
  network = data.google_compute_network.default.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.allowed_source_ranges
  target_tags   = ["rancher"]
}

resource "google_compute_firewall" "allow_nfs" {
  name    = "nfs-server"
  project = local.network_project_id
  network = data.google_compute_network.default.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["2049"]
  }

  source_ranges = var.allowed_source_ranges
  target_tags   = ["nfs-server"]
}

resource "google_compute_firewall" "allow_logs" {
  name    = "logs"
  project = local.network_project_id
  network = data.google_compute_network.default.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["5601", "9200", "9300"]
  }

  source_ranges = var.allowed_source_ranges
  target_tags   = ["logs"]
}
