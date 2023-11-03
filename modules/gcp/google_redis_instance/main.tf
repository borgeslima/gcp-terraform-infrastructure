resource "google_redis_instance" "cache" {
  name                    = lower(try(var.name, ""))
  tier                    = try(var.tier, "STANDARD_HA")
  region                  = try(var.region, "us-east1")
  location_id             = try(var.location_id, "us-east1-b")
  memory_size_gb          = try(var.memory_size_gb, 1)
  authorized_network      = try(var.authorized_network, "default")
  display_name            = try(var.display_name, "")
  reserved_ip_range       = try(var.reserved_ip_range, "10.0.0.0/16")
  auth_enabled            = try(var.auth_enabled, false)
  transit_encryption_mode = try(var.transit_encryption_mode, "SERVER_AUTHENTICATION")
  labels                  = merge({})
}

