variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
  default = "jskjdgs"
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