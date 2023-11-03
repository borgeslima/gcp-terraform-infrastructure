
module "google_sql_database_instance" {

  source = "./gcp/google_sql_database_instance"

  for_each = var.database_instances

  name                = lower("${each.value.name}-${random_string.random.result}")
  project             = var.project_id
  region              = var.region
  deletion_protection = each.value.deletion_protection
  tier                = each.value.tier
  ipv4_enabled        = each.value.ipv4_enabled
  disk_size           = each.value.disk_size
  disk_type           = each.value.disk_type
  database_name       = each.value.database_name
  database_username   = each.value.database_user_name
  database_version    = each.value.database_version
  database_password   = each.value.database_user_password
}

