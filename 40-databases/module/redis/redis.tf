resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet
  vpc_security_group_ids = [local.redis_sg_id]
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-redis"
    }
    )
}

resource "terraform_data" "redis_bootstrap" {
  triggers_replace = [
    aws_instance.redis.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.redis.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis ${var.environment} ${var.app_version}"
     ]
  }
}

resource "aws_route53_record" "redis" {
  zone_id = var.zone_id
  name="redis-${var.environment}.${var.domain_name}"
  type = "A"
  ttl = "1"
  records = [ aws_instance.redis.private_ip ]
}