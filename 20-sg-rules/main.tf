resource "aws_security_group_rule" "bastion_internet" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "mongo_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  #cidr_blocks = [ "0.0.0.0/0" ]
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongo_sg_id
}

resource "aws_security_group_rule" "mongo_catalogue" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = local.catalogue_sg_id
  security_group_id = local.mongo_sg_id
}

resource "aws_security_group_rule" "mongo_user" {
  type = "ingress"
  from_port = 27017
  to_port = 27017
  protocol = "tcp"
  source_security_group_id = local.user_sg_id
  security_group_id = local.mongo_sg_id
}

resource "aws_vpc_security_group_egress_rule" "example" {
  count = length(local.sg_id_list)
  security_group_id = local.sg_id_list[count.index]
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "All"
  to_port     = -1
}