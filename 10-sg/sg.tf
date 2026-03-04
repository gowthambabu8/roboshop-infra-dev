    module "sg" {
      source = "git::https://github.com/gowthambabu8/terraform-aws-sg.git?ref=main"
      project = var.project
      environment = var.environment
      sg_name = var.sg_name
      sg_desc = "Allow ssh traffic from backend services"
      vpc_id = local.vpc_id
    }