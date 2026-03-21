data "aws_ssm_parameter" "frontend_alb_arn"{
    name = "/${var.project}/${var.environment}/frontend_alb_arn"
}

data "aws_cloudfront_cache_policy" "cachingDisabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "cachingOptimized" {
  name = "Managed-CachingOptimized"
}