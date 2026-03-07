resource "aws_route53_record" "mongo" {
  zone_id = var.zone_id
  name="mongo-${var.environment}.${var.domain_name}"
  type = "A"
  ttl = "1"
  records = [ aws_instance.mongo.private_ip ]
}

resource "aws_route53_record" "mongo" {
  zone_id = var.zone_id
  name="redis-${var.environment}.${var.domain_name}"
  type = "A"
  ttl = "1"
  records = [ aws_instance.redis.private_ip ]
}