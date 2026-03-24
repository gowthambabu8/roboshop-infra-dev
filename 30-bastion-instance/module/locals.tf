locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }
  ami_id = data.aws_ami.ubuntu.id
  public_subnet = split(",",data.aws_ssm_parameter.public_subnet_id.value)[0]
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
}