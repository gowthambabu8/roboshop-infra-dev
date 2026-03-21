variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
} 

variable "private_subnet_cidr_blocks" {
  type = list(string)
} 

variable "database_subnet_cidr_blocks" {
  type = list(string)
} 