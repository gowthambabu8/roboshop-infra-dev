locals {
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  mongo_sg_id = data.aws_ssm_parameter.mongo_sg_id.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  user_sg_id = data.aws_ssm_parameter.user_sg_id.value

  sg_id_list = [
    local.bastion_sg_id, local.mongo_sg_id, local.catalogue_sg_id, local.user_sg_id
  ]
}