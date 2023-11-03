module "google_pubsub_topic" {
  source = "./gcp/google_pubsub_topic"

  for_each                   = try(var.pubsubs, {})
  name                       = "${each.value.name}-${random_string.random.result}"
  message_retention_duration = "86600s"
}