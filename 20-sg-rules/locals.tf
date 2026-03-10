locals {
  bastion_sg_id = data.aws_ssm_parameter.bastion_sg_id.value
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
  user_sg_id = data.aws_ssm_parameter.user_sg_id.value
  cart_sg_id = data.aws_ssm_parameter.cart_sg_id.value
  # databases
  redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
  mongo_sg_id = data.aws_ssm_parameter.mongo_sg_id.value
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
  
  backend_alb_sg_id = data.aws_ssm_parameter.backend_alb_sg_id.value

  sg_id_list = [
    local.bastion_sg_id, local.mongo_sg_id, local.catalogue_sg_id, local.user_sg_id, local.redis_sg_id,local.mysql_sg_id,
    local.rabbitmq_sg_id
  ]


  # ports and services
  common_port = 22
  mongo_service_port = 27017
  redis_service_port = 6379
  mysql_service_port = 3306
  rabbitmq_service_port = 5672

}