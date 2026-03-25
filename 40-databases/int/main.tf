module "mongo" {
    source = "../module/mongo"
    project = var.project
    environment = var.environment
    zone_id = var.zone_id
}