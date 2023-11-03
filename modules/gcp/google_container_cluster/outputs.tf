output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "project" {
  value       = var.project
  description = "Obtem o id do projeto"
}

output "endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "Obtem endPoint do cluster"
}

output "access_token" {
  value = data.google_client_config.provider.access_token
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

