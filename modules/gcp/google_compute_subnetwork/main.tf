resource "google_compute_subnetwork" "subnet" {
  name                     = lower(var.name)
  region                   = var.region
  network                  = var.network
  ip_cidr_range            = var.ip_cidr_range
  private_ip_google_access = try(var.private_ip_google_access, true)

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges
    content {
      range_name    = secondary_ip_range.value["range_name"]
      ip_cidr_range = secondary_ip_range.value["ip_cidr_range"]
    }
  }
}