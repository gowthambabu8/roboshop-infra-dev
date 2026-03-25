locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  private_subnet = split(",",data.aws_ssm_parameter.private_subnets_id.value)
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value
}