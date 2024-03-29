variable "project_id" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "service_application_name" {
  type = string
}

variable "postgres_host" {
  type = string
}

variable "vpc_access_connector" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

