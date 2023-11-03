resource "google_compute_router_nat" "nat" {
  name    = var.name
  project = var.project
  router  = var.router
  region  = var.region
  nat_ips = toset(var.nat_ips)
  nat_ip_allocate_option = try(var.nat_ip_allocate_option, "MANUAL_ONLY")
  source_subnetwork_ip_ranges_to_nat = try(var.source_subnetwork_ip_ranges_to_nat, "LIST_OF_SUBNETWORKS")

  dynamic "subnetwork" {

    for_each = var.subnetworks

    content {
      name                    =  subnetwork.value["name"]
      source_ip_ranges_to_nat = try(subnetwork.value["source_ip_ranges_to_nat"], ["PRIMARY_IP_RANGE", "LIST_OF_SECONDARY_IP_RANGES"])
      secondary_ip_range_names = try(subnetwork.value["secondary_ip_range_names"], [])
    }
  }
}