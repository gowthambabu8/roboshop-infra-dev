locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  public_subnets = split(",", data.aws_ssm_parameter.public_subnets_id.value)
  frontend_alb_sg_id = data.aws_ssm_parameter.frontend_alb_sg_id.value
  certificate_arn = data.aws_ssm_parameter.frontend_alb_cert.value
}