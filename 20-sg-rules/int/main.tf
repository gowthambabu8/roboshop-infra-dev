## database services
module "mongo" {
  source = "../module/mongo"
  project = var.project
  environment = var.environment
}

module "mysql" {
  source = "../module/mysql"
  project = var.project
  environment = var.environment
}

module "redis" {
  source = "../module/redis"
  project = var.project
  environment = var.environment
}

module "rabbitmq" {
  source = "../module/rabbitmq"
  project = var.project
  environment = var.environment
}

## backend services
module "catalogue" {
  source = "../module/catalogue"
  project = var.project
  environment = var.environment
}

module "user" {
  source = "../module/user"
  project = var.project
  environment = var.environment
}

module "cart" {
  source = "../module/cart"
  project = var.project
  environment = var.environment
}

module "shipping" {
  source = "../module/shipping"
  project = var.project
  environment = var.environment
}

module "payment" {
  source = "../module/payment"
  project = var.project
  environment = var.environment
}

## frontend services
module "frontend" {
  source = "../module/frontend"
  project = var.project
  environment = var.environment
}

module "frontend_alb" {
  source = "../module/frontend_alb"
  project = var.project
  environment = var.environment
}

module "backend_alb" {
  source = "../module/backend_alb"
  project = var.project
  environment = var.environment
}