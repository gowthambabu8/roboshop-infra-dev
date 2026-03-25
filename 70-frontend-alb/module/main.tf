resource "aws_lb" "frontend_alb" {
    name = "${var.project}-${var.environment}-frontend-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [local.frontend_alb_sg_id] 
    subnets = local.public_subnets
}

resource "aws_lb_listener" "frontend_alb" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "I am from Frontend ALB"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name = "*.${var.domain_name}"
  type = "A"

  alias {
    name = aws_lb.frontend_alb.dns_name
    zone_id = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
  allow_overwrite = true
}

resource "aws_ssm_parameter" "frontend_alb_arn" {
  name = "/${var.project}/${var.environment}/frontend_alb_arn"
  type = "String"
  value = aws_lb_listener.frontend_alb.arn
}