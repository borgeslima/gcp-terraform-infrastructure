provider "google" {
  project = var.project_id
  region  = var.region
}


resource "random_string" "random" {
  length  = 5
  special = false
  numeric = false
}


module "google_container_cluster" {

  source = "./gcp/google_container_cluster"

  project = var.project_id

  name                     = lower("${var.gke_name}-${random_string.random.result}")
  region                   = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  enable_l4_ilb_subsetting = false
  network                  = module.google_compute_network.name
  subnetwork               = module.google_compute_subnetwork.name

  service_external_ips_config = {
    enabled = true
  }

  default_max_pods_per_node = "110"
  enable_kubernetes_alpha   = "false"

  enable_legacy_abac = "true"

  addons_config = {

    http_load_balancing = {
      disabled = false
    }

    gce_persistent_disk_csi_driver_config = {
      enabled = true
    }

    network_policy_config = {
      disabled = false
    }
  }

  maintenance_policy = {
    daily_maintenance_window = {
      start_time = "03:00"
    }
  }

  private_cluster_config = {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block

    master_global_access_config = {
      enabled = true
    }
  }

  enable_intranode_visibility = true

  network_policy = {
    enabled  = true
    provider = "CALICO"
  }

  ip_allocation_policy = {
    cluster_secondary_range_name  = module.google_compute_subnetwork.secondary_ip_range[0].range_name
    services_secondary_range_name = module.google_compute_subnetwork.secondary_ip_range[1].range_name
  }

  master_auth = {
    client_certificate_config = {
      issue_client_certificate = true
    }
  }
}

data "google_client_config" "provider" {}



module "google_container_node_pool" {

  source = "./gcp/google_container_node_pool"

  for_each = var.node_pools

  name       = module.google_container_cluster.cluster_name
  cluster    = module.google_container_cluster.cluster_name
  region     = var.region
  node_count = each.value.node_count

  autoscaling = {
    total_min_node_count = 1
    total_max_node_count = 4
    location_policy      = "BALANCED"
  }

  node_config = {

    machine_type = each.value.machine_type
    disk_type    = each.value.disk_type
    disk_size_gb = each.value.disk_size_gb
    preemptible  = each.value.preemptible

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    tags = []

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {}
  }

  depends_on = [module.google_container_cluster]
}


