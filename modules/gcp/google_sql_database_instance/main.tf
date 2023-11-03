resource "google_sql_database_instance" "instance" {
  provider            = google-beta
  name                = lower(var.name)
  project             = var.project
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled = var.ipv4_enabled
    }
    disk_size = var.disk_size
    disk_type = var.disk_type
  }
}

resource "google_sql_database" "database" {
  name       = var.database_name
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_database_instance.instance]
}

resource "google_sql_user" "user" {
  instance = google_sql_database_instance.instance.name
  name     = var.database_username
  password = var.database_password

  depends_on = [google_sql_database_instance.instance]
}