data "aws_ssm_parameter" "frontend_alb_sg_id"{
    name = "/${var.project}/${var.environment}/frontend_alb_sg_id"
}

data "aws_ssm_parameter" "public_subnets_id"{
    name = "/${var.project}/${var.environment}/public_subnet"
}

data "aws_ssm_parameter" "frontend_alb_cert"{
    name = "/${var.project}/${var.environment}/certificate_arn_roboshop"
}