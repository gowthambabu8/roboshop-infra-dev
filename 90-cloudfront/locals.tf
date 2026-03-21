locals {
  common_tags = {
    Name = "${var.project}-${var.environment}"
    Project = var.project
    Environment = var.environment
    Terraform = true
  }

  certificate_arn = data.aws_ssm_parameter.certificate_arn_roboshop.value
  cachingDisabled = data.aws_cloudfront_cache_policy.cachingDisabled.id
  cachingOptimized = data.aws_cloudfront_cache_policy.cachingOptimized.id 
}