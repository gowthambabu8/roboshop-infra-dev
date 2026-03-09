data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["973714476881"] # Canonical

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "database_subnet_id" {
  name = "/${var.project}/${var.environment}/database_subnet"
}

data "aws_ssm_parameter" "mongo_sg_id" {
  name = "/${var.project}/${var.environment}/mongo_sg_id"
}

data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${var.project}/${var.environment}/redis_sg_id"
}

data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${var.project}/${var.environment}/mysql_sg_id"
}