output "private_subnet" {
  value = data.aws_ssm_parameter.private_subnet_id.value
  sensitive = true
}

output "catalogue_sg_id" {
  value = data.aws_ssm_parameter.catalogue_sg_id.value
  sensitive = true
}