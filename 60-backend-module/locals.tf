locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  ami_id = data.aws_ami.ubuntu.id
  subnet_id = split(",",data.aws_ssm_parameter.private_subnet_id.value)[0]
  sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  backend_alb_arn = data.aws_ssm_parameter.backend_alb_arn.value
  component = "backend"
  app_version = "v1"
  port_number = 8080
  health_check_path = "/health"
  domain_name = "happielearning.com"
}