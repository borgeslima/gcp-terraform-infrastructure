terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.47.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }

  required_version = ">= 0.14"
}