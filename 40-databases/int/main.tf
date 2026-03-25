module "mongo" {
    source = "../module/mongo"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
}

module "redis" {
    source = "../module/redis"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
}

module "mysql" {
    source = "../module/mysql"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
}

module "rabbitmq" {
    source = "../module/rabbitmq"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
}