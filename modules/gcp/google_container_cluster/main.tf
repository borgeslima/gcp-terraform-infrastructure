provider "google" {
  project = var.project
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name                     = var.name
  location                 = var.region
  remove_default_node_pool = try(var.remove_default_node_pool, false)
  initial_node_count       = try(var.initial_node_count, 1)
  enable_l4_ilb_subsetting = try(var.enable_l4_ilb_subsetting, false)
  network                  = var.network
  subnetwork               = var.subnetwork

  service_external_ips_config {
    enabled = try(var.service_external_ips_config.enabled, true)
  }

  default_max_pods_per_node = try(var.default_max_pods_per_node, 3)
  enable_kubernetes_alpha   = try(var.enable_kubernetes_alpha, true)

  enable_legacy_abac = var.enable_legacy_abac

  addons_config {

    http_load_balancing {
      disabled = try(var.addons_config.http_load_balancing.disable, true)
    }

    gce_persistent_disk_csi_driver_config {
      enabled = try(var.addons_config.gce_persistent_disk_csi_driver_config.enabled, true)
    }

    network_policy_config {
      disabled = try(var.addons_config.network_policy_config.disabled, true)
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = try(var.maintenance_policy.daily_maintenance_window.start_time, "03:00")
    }
  }

  private_cluster_config {
    enable_private_endpoint = try(var.private_cluster_config.enable_private_endpoint, true)
    enable_private_nodes    = try(var.private_cluster_config.enable_private_nodes, true)
    master_ipv4_cidr_block  = try(var.private_cluster_config.master_ipv4_cidr_block, "192.0.0.0/16")

    master_global_access_config {
      enabled = try(var.private_cluster_config.master_global_access_config.enabled, true)
    }
  }

  enable_intranode_visibility = try(var.enable_intranode_visibility, true)

  network_policy {
    enabled  = try(var.network_policy.enabled, true)
    provider = try(var.network_policy.provider, "CALICO")
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = try(var.ip_allocation_policy.cluster_secondary_range_name, "10.0.0.0/20")
    services_secondary_range_name = try(var.ip_allocation_policy.services_secondary_range_name, "10.0.0.0/20")
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = try(var.master_auth.client_certificate_config.issue_client_certificate, true)
    }
  }
}


data "google_client_config" "provider" {}