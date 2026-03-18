resource "aws_security_group_rule" "user_bastion" {
  type = "ingress"
  from_port = local.common_port
  to_port = local.common_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.user_sg_id
}

resource "aws_security_group_rule" "user_backend_alb" {
  type = "ingress"
  from_port = local.backend_service_port
  to_port = local.backend_service_port
  protocol = "tcp"
  source_security_group_id = local.backend_alb_sg_id
  security_group_id = local.user_sg_id
}
