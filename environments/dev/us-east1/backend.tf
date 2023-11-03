terraform {
  backend "gcs" {
    bucket = "gcp-infrastructure"
    prefix = "terraform/infrastructure"
  }
}