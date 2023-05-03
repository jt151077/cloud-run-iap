variable "project_id" {
  type = string
}

variable "project_nmr" {
  type = number
}

variable "project_default_region" {
  type = string
}

variable "iap_brand_support_email" {
  type = string
}

variable "domain" {
  type = string
}

variable "path_matcher" {
  type = string
}

variable "iap_authorised_users" {
  type = list(string)
}

variable "default_run_image" {
  type    = string
  default = "nginx:latest"
}

variable "run_service_id" {
  type = string
}