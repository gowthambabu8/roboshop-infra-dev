    module "sg" {
      count = length(var.sg_names)
      source = "git::https://github.com/gowthambabu8/terraform-aws-sg.git?ref=main"
      project = var.project
      environment = var.environment
      sg_name = replace("${var.project}-${var.environment}-${var.sg_names[count.index]}","_","-")
      sg_desc = "Allow ssh traffic from backend services"
      vpc_id = local.vpc_id
    }