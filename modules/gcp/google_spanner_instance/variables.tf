variable "config" {
  type = string
}

variable "processing_units" {
  type = number
  default = 100
}

variable "display_name" {
  type = string
}

variable "databases" {
    type = any
}