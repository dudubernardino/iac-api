locals {
  db_username = "admin"
  db_password = "admin"
}

module "postgresql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "14.0.1"

  name                 = "${var.project_id}-db"
  random_instance_name = true
  project_id           = var.project_id
  database_version     = "POSTGRES_14"
  region               = var.region
  zone                 = var.zone

  deletion_protection = var.deletion_protection

  database_flags = []

  user_labels = {
  }

  db_name      = "${var.project_id}-db"
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  user_name     = local.db_username
  user_password = local.db_password

  create_timeout = "30m"
}
