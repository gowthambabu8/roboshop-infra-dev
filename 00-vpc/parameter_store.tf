resource "aws_ssm_parameter" "vpc_id" {
  name = "/roboshop/dev/vpc_id"
  type="String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet" {
  name = "/${var.project}/${var.environment}/public_subnet"
  type = "StringList"
  value = join(",",module.vpc.public_subnets)
}

resource "aws_ssm_parameter" "private_subnet" {
  name = "/${var.project}/${var.environment}/private_subnet"
  type = "StringList"
  value = join(",",module.vpc.private_subnets)
}

resource "aws_ssm_parameter" "database_subnet" {
  name = "/${var.project}/${var.environment}/database_subnet"
  type = "StringList"
  value = join(",",module.vpc.database_subnets)
}