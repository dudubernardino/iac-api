module "iac_api_project_factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 10.1"

  project_id = var.project_id
  name       = var.service_application_name

  auto_create_network     = false
  create_project_sa       = false
  random_project_id       = false
  default_service_account = "disable"
  activate_apis = [
    "iam.googleapis.com",
    "run.googleapis.com",
    "sql-component.googleapis.com",
    "secretmanager.googleapis.com",
    "storage.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com",
    "apigateway.googleapis.com",
    "servicecontrol.googleapis.com",
    "servicemanagement.googleapis.com",
    "artifactregistry.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com"
  ]
}
