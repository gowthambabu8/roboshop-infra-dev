    module "vpc" {
      source = "git::https://github.com/gowthambabu8/terraform-aws-vpc.git//vpc"
      project = var.project
      environment = var.environment
      is_peering_required= false
      cidr_block = var.cidr_block
      public_subnet_cidr = var.public_subnet_cidr_blocks 
      private_subnet_cidr = var.private_subnet_cidr_blocks
      database_subnet_cidr = var.database_subnet_cidr_blocks
    }