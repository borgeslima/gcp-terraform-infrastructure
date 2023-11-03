output "name" {
  value = google_compute_subnetwork.subnet.name
}

output "secondary_ip_range" {
  value = google_compute_subnetwork.subnet.secondary_ip_range
}

output "self_link" {
  value = google_compute_subnetwork.subnet.self_link
}