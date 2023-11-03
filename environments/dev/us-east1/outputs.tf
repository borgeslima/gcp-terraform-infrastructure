output "region" {
  value       = var.region
}

output "cluster_name" {
  value = module.google_container_cluster.cluster_name
}

output "project_id" {
  value       = var.project_id
}