module "google_redis_instance" {

  source = "./gcp/google_redis_instance"

  for_each = var.redis_instances

  name                    = "${each.value.name}-${random_string.random.result}"
  tier                    = try(each.value.tier, "STANDARD_HA")
  region                  = try(each.value.region, "us-east1")
  location_id             = try(each.value.location_id, "us-east1-d")
  reserved_ip_range       = try(each.value.reserved_ip_range, "10.0.0.0/29")
  memory_size_gb          = try(each.value.memory_size_gb, 5)
  auth_enabled            = try(each.value.auth_enabled, true)
  transit_encryption_mode = try(each.value.transit_encryption_mode, "SERVER_AUTHENTICATION")
  display_name            = "${each.value.name}-${random_string.random.result}"
  authorized_network      = module.google_compute_network.id
  depends_on              = [module.google_container_cluster, module.google_container_node_pool, module.google_compute_network]
}