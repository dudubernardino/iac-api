resource "google_service_account" "iac_api_service_account" {
  display_name = "Cloud Build Service Account para OPS"
  account_id   = "iac-api"
  project      = var.project_id
}

resource "google_project_iam_member" "serviceAccount_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "servicemanagement_admin" {
  project = var.project_id
  role    = "roles/servicemanagement.admin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "service_usage_admin" {
  project = var.project_id
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "cloudsql_admin" {
  project = var.project_id
  role    = "roles/cloudsql.admin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "network_admin" {
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "service_account_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountCreator"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}

resource "google_project_iam_member" "run_admin" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.iac_api_service_account.email}"
}
