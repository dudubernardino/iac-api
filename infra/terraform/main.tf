terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.5"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.5"
    }
  }
}


provider "google" {
  project     = var.project_id
  credentials = file(var.credentials_file)
  region      = var.region
  zone        = var.zone
}

module "project_ops_iac_api" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "~> 14.1"

  project_id = var.project_id

  activate_apis = [
    "iam.googleapis.com",
    "iap.googleapis.com",
    "admin.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "run.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "secretmanager.googleapis.com",
    "storage.googleapis.com",
    "artifactregistry.googleapis.com",
    "container.googleapis.com"
  ]
}

module "postgres" {
  source              = "./postgres"
  project_id          = var.project_id
  region              = var.region
  zone                = var.zone
  deletion_protection = false
}

module "cloud_run_service" {
  source                   = "./cloud_run"
  project_id               = var.project_id
  docker_image_name        = var.docker_image_name
  service_application_name = var.service_application_name
  container_port           = 3000
  region                   = var.region
  postgres_host            = module.postgres.postgres_internal_ip
}




