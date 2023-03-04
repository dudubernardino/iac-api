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

        dynamic "env" {
          for_each = tomap({
            "POSTGRES_HOST" = var.postgres_host
            "POSTGRES_PORT" : "5432"
            "POSTGRES_USER"     = "admin"
            "POSTGRES_PASSWORD" = "admin"
            "POSTGRES_DB"       = "${var.project_id}-db"
          })
          content {
            name  = env.key
            value = env.value
          }
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


