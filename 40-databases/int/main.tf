module "mongo" {
    source = "../module/mongo"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
}

module "redis" {
    source = "../module/redis"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
}

module "mysql" {
    source = "../module/mysql"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
}

module "rabbitmq" {
    source = "../module/rabbitmq"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
}