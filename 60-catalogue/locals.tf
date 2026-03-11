locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  ami_id = data.aws_ami.ubuntu.id
  private_subnet = split(",",data.aws_ssm_parameter.private_subnet_id.value)[0]
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
}