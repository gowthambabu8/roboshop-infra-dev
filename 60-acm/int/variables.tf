variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "app_version" {
  default = "v3"
}

variable "component" {
  default = "roboshop"
}