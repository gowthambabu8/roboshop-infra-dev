resource "aws_security_group_rule" "backend_alb_bastion_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_frontend" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.front_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_catalogue" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.catalogue_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_user" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.user_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_cart" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.cart_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_shipping" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.shipping_sg_id
  security_group_id = local.backend_alb_sg_id
}

resource "aws_security_group_rule" "backend_alb_payment" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = local.payment_sg_id
  security_group_id = local.backend_alb_sg_id
}