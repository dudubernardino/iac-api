terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}


provider "google" {
  project     = var.project_id
  credentials = file(var.credentials_file)
  region      = var.region
  zone        = var.zone
}

resource "google_project_service" "project" {
  project = var.project_id
  service = "iam.googleapis.com"

  disable_dependent_services = true
}

module "cloud_run_service" {
  source            = "./cloud_run"
  project_id        = var.project_id
  docker_image_name = var.docker_image_name
  service_application_name = var.service_application_name
  container_port    = 3000
  region            = var.region
}


