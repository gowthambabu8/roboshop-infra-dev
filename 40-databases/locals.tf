locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  ami_id = data.aws_ami.ubuntu.id
  database_subnet = split(",",data.aws_ssm_parameter.database_subnet_id.value)[0]
  mongo_sg_id = data.aws_ssm_parameter.mongo_sg_id.value
}