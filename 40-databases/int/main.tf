module "mongo" {
    source = "../module/mongo"
    project = var.project
    environment = var.environment
}