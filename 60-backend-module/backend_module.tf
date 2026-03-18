    module "vpc" {
      source = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
      #source = "C://Users//ADMIN//Downloads//DevOps//git-repo//terraform-roboshop-component"
      project = var.project
      environment = var.environment
      subnet_id = local.subnet_id
      sg_id = local.sg_id
      ami_id = local.ami_id
      component = local.component
      app_version = local.app_version
      port_number = local.port_number
      vpc_id = local.vpc_id
      health_check_path = local.health_check_path
      backend_alb_arn = local.backend_alb_arn
      domain_name = local.domain_name
    }