resource "aws_security_group_rule" "frontend_bastion" {
  type = "ingress"
  from_port = local.common_port
  to_port = local.common_port
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.front_sg_id
}

resource "aws_security_group_rule" "frontend_frontend_alb" {
  type = "ingress"
  from_port = local.http_port
  to_port = local.http_port
  protocol = "tcp"
  source_security_group_id = local.frontend_alb_sg_id
  security_group_id = local.front_sg_id
}