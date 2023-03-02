variable "projectId" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

