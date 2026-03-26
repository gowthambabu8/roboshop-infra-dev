module "mongo" {
    source = "../module/mongo"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
    app_version = var.app_version
}

module "redis" {
    source = "../module/redis"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
    app_version = var.app_version
}

module "mysql" {
    source = "../module/mysql"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
    app_version = var.app_version
}

module "rabbitmq" {
    source = "../module/rabbitmq"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
    domain_name = var.domain_name
    app_version = var.app_version
}