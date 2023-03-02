# Enables the Cloud Run API
resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name     = var.projectId
  location = var.region

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
resource "google_cloud_run_service_iam_policy" "public_access" {
  service     = google_cloud_run_service.run_service.name
  location    = google_cloud_run_service.run_service.location
  policy_data = google_iam_policy.pub-1
}

data "google_iam_policy" "pub-1" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}
