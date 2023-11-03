variable "name" {
  type = string
}

variable "reserved_ip_range" {
  type = string
}

variable "region" {
  type = string
}

variable "transit_encryption_mode" {
  type = string
}

variable "tier" {
  type    = string
  default = "STANDARD_HA"
}

variable "redis_version" {
  type = string
  default = "REDIS_4_0"
}

variable "memory_size_gb" {
  type    = number
  default = 1
}

variable "authorized_network" {
  type = string
}

variable "display_name" {
  type = string
}

variable "location_id" {
  type    = string
  default = "us-central1-a"
}

variable "alternative_location_id" {
  type    = string
  default = "us-central1-f"
}

variable "auth_enabled" {
  type    = bool
  default = false
}

variable "persistence_config" {
  type = object({
    persistence_mode    = string
    rdb_snapshot_period = string
  })

  default = {
    persistence_mode    = "RDB"
    rdb_snapshot_period = "TWELVE_HOURS"
  }
}