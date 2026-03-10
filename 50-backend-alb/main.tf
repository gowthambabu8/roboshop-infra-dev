resource "aws_lb" "backend" {
    name = "${var.project}-${var.environment}-alb"
    internal = true
    load_balancer_type = "application"
    security_groups = [local.backend_alb_sg_id] 
    subnets = local.private_subnet
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.backend.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name = "*.backend_alb-${var.environment}.${var.domain_name} "
  type = "A"

  alias {
    name = aws_lb.backend.name
    zone_id = aws_lb.backend.zone_id
    evaluate_target_health = true
  }
}