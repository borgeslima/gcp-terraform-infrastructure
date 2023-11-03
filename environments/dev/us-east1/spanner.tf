module "google_spanner_instance" {
  source           = "./gcp/google_spanner_instance"
  for_each         = try(var.spanners, {})
  config           = each.value.config
  display_name     = "${each.value.name}-${random_string.random.result}"
  processing_units = each.value.processing_units
  databases        = each.value.databases
}
