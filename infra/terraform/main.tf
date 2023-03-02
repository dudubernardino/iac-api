terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}


provider "google" {
  project     = var.projectId
  credentials = file(var.credentials_file)
  region      = var.region
  zone        = var.zone
}

module "cloud_run_service" {
  source            = "./cloud_run"
  projectId         = var.projectId
  docker_image_name = var.docker_image_name
  region            = var.region
}


