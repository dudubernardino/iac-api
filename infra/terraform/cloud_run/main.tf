# Enables the Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name     = var.service_application_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.docker_image_name

        ports {
          container_port = var.container_port
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Waits for the Cloud Run API to be enabled
  depends_on = [google_project_service.run_api]
}

# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_binding" "public_access" {
  project  = google_cloud_run_service.run_service.project
  service  = google_cloud_run_service.run_service.name
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  members  = ["allUsers"]

  # Waits for the Cloud Run API to be enabled
  depends_on = [google_cloud_run_service.run_service]
}


