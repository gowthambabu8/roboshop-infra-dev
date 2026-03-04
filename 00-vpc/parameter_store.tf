resource "aws_ssm_parameter" "vpc_id" {
  name = "/roboshop/dev/vpc_id"
  type="String"
  value = module.vpc.vpc_id
}