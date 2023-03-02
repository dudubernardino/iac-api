terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
  }
}


provider "google" {
  project     = var.projectId
  credentials = var.credentials_file
  region      = var.region
  zone        = var.zone
}


