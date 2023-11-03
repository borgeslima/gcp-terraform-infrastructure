resource "google_spanner_instance" "instance" {
  config       = try(var.config, "regional-us-east5")
  display_name = try(var.display_name, "")
  processing_units = try(var.processing_units, 100)
}

resource "google_spanner_database" "database" {
  for_each = var.databases
  instance = google_spanner_instance.instance.name
  name     = each.value.name
  version_retention_period = try(each.value.version_retention_period, "3d")
  ddl = toset(each.value.ddl)
  deletion_protection = false
}