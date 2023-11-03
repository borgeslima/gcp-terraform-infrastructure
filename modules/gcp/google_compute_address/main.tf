resource "google_compute_address" "nat" {
   name    = var.name
   project = var.project
   region  = var.region
}