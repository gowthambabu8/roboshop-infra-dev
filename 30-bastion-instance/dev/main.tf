module "bastion_instance" {
  source = "../module"
  project = var.project
  environment = var.environment
}