resource "aws_security_group_rule" "redis_bastion" {
  type = "ingress"
  from_port = local.common_port
  to_port = local.common_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_bastion_common" {
  type = "ingress"
  from_port = local.redis_service_port
  to_port = local.redis_service_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  type = "ingress"
  from_port = local.redis_service_port
  to_port = local.redis_service_port
  protocol = "tcp"
  source_security_group_id = local.cart_sg_id
  security_group_id = local.mongo_sg_id
}