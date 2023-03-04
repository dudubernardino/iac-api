# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name     = var.service_application_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      service_account_name = google_service_account.cloud_run_service_account.email
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
}

data "google_iam_policy" "iam_policy" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "iam_policy" {
  location = google_cloud_run_service.run_service.location
  service  = google_cloud_run_service.run_service.name

  policy_data = data.google_iam_policy.iam_policy.policy_data
}


