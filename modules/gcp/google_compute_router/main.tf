resource "google_compute_router" "router" {
  name    = var.name
  project = var.project
  region  = var.region
  network = var.network

  bgp {
    asn = 64514
  }
}