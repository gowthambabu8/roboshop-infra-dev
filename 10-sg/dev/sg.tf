    module "sg" {
      count = length(var.sg_names)
      source = "git::https://github.com/gowthambabu8/terraform-aws-sg.git//sg"
      project = var.project
      environment = var.environment
      sg_name = var.sg_names[count.index]
      sg_desc = "Allow ssh traffic from backend services"
      vpc_id = var.vpc_id
    }