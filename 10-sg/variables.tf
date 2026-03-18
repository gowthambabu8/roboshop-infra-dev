variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = "mongodb"
}

variable "sg_names"{
  default = [ 
    # databases
    "mongo","redis","mysql","rabbitmq",
    # backend
    "catalogue","cart","user","shipping","payment",
    # frontend
    "frontend",
    # backend ALB
    "backend_alb",
    # frontend ALB
    "frontend_alb",
    "bastion"
  ]
}