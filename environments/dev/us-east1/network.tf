
# ############ VPC ###############


module "google_compute_network" {
  source = "./gcp/google_compute_network"

  name                    = lower("${var.vpc_name}-${random_string.random.result}")
  auto_create_subnetworks = "false"
  project                 = var.project_id
}

# ############# SUB ###############

module "google_compute_subnetwork" {

  source = "./gcp/google_compute_subnetwork"

  name                     = lower("${var.subnet_name}-${random_string.random.result}")
  region                   = var.region
  network                  = module.google_compute_network.name
  private_ip_google_access = true
  ip_cidr_range            = var.subnet_ip_cidr_range

  secondary_ip_ranges = {

    pod_range = {
      range_name    = format("%s-pod-range", module.google_compute_network.name)
      ip_cidr_range = var.subnet_secondary_ip_range_pods
    }

    service_range = {
      range_name    = format("%s-svc-range", module.google_compute_network.name)
      ip_cidr_range = var.subnet_secondary_ip_range_service
    }
  }

  depends_on = [
    module.google_compute_network
  ]
}

# # ############# ADDRESS ###############

module "google_compute_address" {
  source  = "./gcp/google_compute_address"
  name    = format("%s-nat-ip", module.google_compute_network.name)
  project = var.project_id
  region  = var.region

  depends_on = [
    module.google_compute_network
  ]
}

# # ############# ROUTER ###############

module "google_compute_router" {
  source  = "./gcp/google_compute_router"
  name    = format("%s-cloud-router", module.google_compute_network.name)
  project = var.project_id
  region  = var.region
  network = module.google_compute_network.name

  depends_on = [
    module.google_compute_network
  ]
}

# # ############# NAT ###############

module "google_compute_router_nat" {

  source = "./gcp/google_compute_router_nat"

  name                               = format("%s-cloud-nat", module.google_compute_network.name)
  project                            = var.project_id
  router                             = module.google_compute_router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [module.google_compute_address.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetworks = {
    subnet = {
      name                    = "${module.google_compute_subnetwork.self_link}"
      source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE", "LIST_OF_SECONDARY_IP_RANGES"]
      secondary_ip_range_names = [
        module.google_compute_subnetwork.secondary_ip_range.0.range_name,
        module.google_compute_subnetwork.secondary_ip_range.1.range_name,
      ]
    }
  }
  depends_on = [
    module.google_compute_network
  ]
}

# ############# PEERING ###############


module "google_compute_network_peering_left" {

  source = "./gcp/google_compute_network_peering"

  for_each = try(var.perring_networks, {})

  name                                = "${var.project_id}-to-${each.value.peer_project}"
  network                             = "projects/${var.project_id}/global/networks/${module.google_compute_network.name}"
  peer_network                        = "projects/${each.value.peer_project}/global/networks/${each.value.peer_network}"
  import_custom_routes                = try(each.value.import_custom_routes, false)
  export_custom_routes                = try(each.value.export_custom_routes, false)
  import_subnet_routes_with_public_ip = try(each.value.import_subnet_routes_with_public_ip, false)

  depends_on = [
    module.google_compute_network
  ]
}

module "google_compute_network_peering_right" {

  source = "./gcp/google_compute_network_peering"

  for_each = try(var.perring_networks, {})

  name                                = "${each.value.peer_project}-to-${var.project_id}"
  network                             = "projects/${each.value.peer_project}/global/networks/${each.value.peer_network}"
  peer_network                        = "projects/${var.project_id}/global/networks/${module.google_compute_network.name}"
  import_custom_routes                = try(each.value.import_custom_routes, false)
  export_custom_routes                = try(each.value.export_custom_routes, false)
  import_subnet_routes_with_public_ip = try(each.value.import_subnet_routes_with_public_ip, false)

  depends_on = [
    module.google_compute_network
  ]
}