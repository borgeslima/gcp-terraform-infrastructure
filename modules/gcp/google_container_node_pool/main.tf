resource "google_container_node_pool" "node_pool" {

  name       = var.name
  location   = var.region
  cluster    = var.cluster
  node_count = var.node_count

  autoscaling {
    total_min_node_count = var.autoscaling.total_min_node_count
    total_max_node_count = var.autoscaling.total_max_node_count
    location_policy      = var.autoscaling.location_policy
  }

  node_config {

    machine_type = var.node_config.machine_type
    disk_type    = var.node_config.disk_type
    disk_size_gb = var.node_config.disk_size_gb
    preemptible  = var.node_config.preemptible

    oauth_scopes = try(var.node_config.oauth_scopes, toset([
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/cloud-platform",
    ]))

    tags = try(var.tags, [])
    metadata = try(var.metadata, {})
    labels = try(var.labels, {})
  }

  timeouts {
    create = try(var.timeouts.create, "30m")
    update = try(var.timeouts.update, "30m")
  }
}