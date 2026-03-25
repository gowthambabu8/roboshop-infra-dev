variable "project" {
  type = string
}

variable "environment" {
  type = string
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