variable "project" {
  type = string
  default = "roboshop"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "components" {
  default = {
    catalogue = {
      rule_priority = 10
    }
  }
}
