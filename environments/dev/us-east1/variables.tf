variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}

variable "master_ipv4_cidr_block" {
  description = "master_ipv4_cidr_block"
}

variable "helms" {
  type = any
}

variable "redis_instances" {
  type = any
}

variable "node_pools" {
  type = any
}

variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "vpc_name" {
  description = "vpc_name"
}

variable "subnet_name" {
  description = "subnet_name"
}

variable "subnet_ip_cidr_range" {
  description = "gke_subnet_ip_cidr_range"
}

variable "subnet_secondary_ip_range_pods" {
  description = "gke_subnet_secondary_ip_range_pods"
}

variable "subnet_secondary_ip_range_service" {
  description = "subnet_secondary_ip_range_service"
}

variable "perring_networks" {
  description = "perring_networks"
}

variable "pubsubs" {
  type        = any
  description = "pubsubs"
}

variable "database_instances" {
  type        = any
  description = "database_instances"
}

variable "gke_name" {
  type        = string
  description = "gke_name"
}

variable "spanners" {
  type = map(object({
    name             = string
    processing_units = number
    config           = string
    databases = map(object({
      name                     = string
      version_retention_period = string
      ddl                      = list(string)
    }))
  }))
}