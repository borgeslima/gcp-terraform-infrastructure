variable "project" {
    type = string
}
variable "region" {
    type = string
}
variable "name" {
    type = string
}
variable "remove_default_node_pool" {
    type = bool
}
variable "initial_node_count" {
    type = number
}
variable "enable_l4_ilb_subsetting" {
    type = bool
}
variable "network" {
    type = string
}
variable "subnetwork" {
    type = string
}

variable "service_external_ips_config" {
  type = object({
    enabled = bool
  })
  default = {
    enabled = false
  }
}

variable "default_max_pods_per_node" {
    type = number
}

variable "enable_kubernetes_alpha" {
  type = bool
}

variable "enable_legacy_abac" {
  type = bool
}

variable "addons_config" {}

variable "maintenance_policy" {}


variable "private_cluster_config" {
  type = object({
    enable_private_endpoint = bool
    enable_private_nodes = bool
    master_ipv4_cidr_block = string
    master_global_access_config = object({
      enabled = bool
    })
  })
}

variable "enable_intranode_visibility" {
  type = bool
}

variable "network_policy" {
  type = object({
    enabled = bool
    provider = string
  })
}

variable "ip_allocation_policy" {
    type = object({
      cluster_secondary_range_name = string
      services_secondary_range_name = string
    }) 
}

variable "master_auth" {
  type = object({
    client_certificate_config = object({
      issue_client_certificate = bool
    })
  })
}


