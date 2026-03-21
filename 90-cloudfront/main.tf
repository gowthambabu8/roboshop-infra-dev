resource "aws_cloudfront_distribution" "main" {
  origin {
    # https://front-dev.happielearning.com
    domain_name = "frontend-${var.environment}.${var.domain_name}"
    origin_id = "frontend-${var.environment}.${var.domain_name}"
    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2","TLSv1.3"]
    }
  }

  enabled = true
  is_ipv6_enabled = false

  # https://roboshop-dev.happielearning.com
  aliases = [ "${var.project}-${var.environment}.${var.domain_name}"  ]
  
  # default behaviour
  default_cache_behavior {
    allowed_methods = ["DELETE","PATCH","POST","PUT","GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https_only"
    cache_policy_id = local.cachingDisabled
    }

  # default behaviour
  ordered_cache_behavior {
    path_pattern = "/media/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https_only"
    cache_policy_id = local.cachingOptimized
    }

    # default behaviour
  ordered_cache_behavior {
    path_pattern = "/images/*"
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "frontend-${var.environment}.${var.domain_name}"
    viewer_protocol_policy = "https_only"
    cache_policy_id = local.cachingOptimized
    }

    price_class = "PriceClass_All"

    restrictions {
      geo_restriction {
        restriction_type = "none"
      }
    }

    viewer_certificate {
      acm_certificate_arn = local.certificate_arn
      ssl_support_method = "sni-only"
    }

     tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }
    )
  }