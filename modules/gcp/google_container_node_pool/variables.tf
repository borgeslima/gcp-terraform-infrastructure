variable "name" {
  type = string
}

variable "cluster" {
  type = string
}

variable "region" {
  type = string
}

variable "autoscaling" {
  type = any
}

variable "node_count" {
  type = number
}

variable "node_config" {
  type = any
}

variable "tags" {
  type = list(string)
  default = []
}

variable "timeouts" {
  type = any
  default = {}
}

variable "metadata" {
  type = any
  default = {}
}

variable "labels" {
  type = any
  default = {}
}