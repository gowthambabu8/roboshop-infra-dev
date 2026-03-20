resource "aws_security_group_rule" "rabbitmq_bastion" {
  type = "ingress"
  from_port = local.common_port
  to_port = local.common_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_bastion_common" {
  type = "ingress"
  from_port = local.rabbitmq_service_port
  to_port = local.rabbitmq_service_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_cart" {
  type = "ingress"
  from_port = local.rabbitmq_service_port
  to_port = local.rabbitmq_service_port
  protocol = "tcp"
  source_security_group_id = local.cart_sg_id
  security_group_id = local.rabbitmq_sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  type = "ingress"
  from_port = local.rabbitmq_service_port
  to_port = local.rabbitmq_service_port
  protocol = "tcp"
  source_security_group_id = local.payment_sg_id
  security_group_id = local.rabbitmq_sg_id
}