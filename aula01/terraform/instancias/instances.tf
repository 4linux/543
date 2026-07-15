locals {
  project_ids       = data.terraform_remote_state.projetos.outputs.project_ids
  target_project_id = var.bootstrap_project_id
  network_self_link = data.terraform_remote_state.rede.outputs.network_self_link
  external_ips      = data.terraform_remote_state.rede.outputs.external_ips

  instances = {
    rancher = {
      machine_type   = "e2-medium"
      disk_size_gb   = 30
      disk_type      = "pd-balanced"
      tags           = ["rancher"]
      startup_script = null
    }

    nfs-server = {
      machine_type = "e2-medium"
      disk_size_gb = 100
      disk_type    = "pd-ssd"
      tags         = ["nfs-server"]
      startup_script = <<-EOT
        #!/bin/bash
        set -euxo pipefail

        export DEBIAN_FRONTEND=noninteractive

        apt-get update
        apt-get install -y nfs-kernel-server nfs-common vim

        mkdir -p /nfs /nfs2 /backups
        chown nobody:nogroup /nfs /nfs2 /backups

        cat > /etc/exports <<'EOF'
        /nfs *(rw,sync,no_subtree_check,no_root_squash)
        /nfs2 *(rw,sync,no_subtree_check,no_root_squash)
        /backups *(rw,sync,no_subtree_check,no_root_squash)
        EOF

        exportfs -ra
        systemctl enable nfs-kernel-server
        systemctl restart nfs-kernel-server
      EOT
    }

    custom = {
      machine_type   = "e2-standard-4"
      disk_size_gb   = 50
      disk_type      = "pd-balanced"
      tags           = ["logs"]
      startup_script = null
    }
  }
}

data "google_compute_image" "ubuntu" {
  family  = var.ubuntu_image_family
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "vm" {
  for_each = local.instances

  name         = each.key
  project      = local.target_project_id
  machine_type = each.value.machine_type
  zone         = var.zone
  tags         = each.value.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = each.value.disk_size_gb
      type  = each.value.disk_type
    }
  }

  network_interface {
    network = local.network_self_link

    access_config {
      nat_ip = local.external_ips[each.key]
    }
  }

  metadata_startup_script = each.value.startup_script
}
