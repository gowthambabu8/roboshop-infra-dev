module "backend_module" {
    source = "../module"
    project = var.project
    environment = var.environment
    domain_name = var.domain_name
}