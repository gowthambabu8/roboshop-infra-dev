module "acm" {
  source = "../module"
  project = var.project
  environment = var.environment
  zone_id = var.zone_id
  domain_name = var.domain_name
  component = var.component
  app_version = var.app_version
}