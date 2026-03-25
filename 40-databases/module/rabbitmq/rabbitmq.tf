resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
    )
}

resource "terraform_data" "rabbitmq_bootstrap" {
  triggers_replace = [
    aws_instance.rabbitmq.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.rabbitmq.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq ${var.environment} ${var.app_version}"
     ]
  }
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.zone_id
  name="rabbitmq-${var.environment}.${var.domain_name}"
  type = "A"
  ttl = "1"
  records = [ aws_instance.rabbitmq.private_ip ]
}