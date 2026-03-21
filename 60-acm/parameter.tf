resource "aws_ssm_parameter" "certificate_roboshop" {
  name = "/${var.project}/${var.environment}/certificate_arn_roboshop"
  type = "String"
  value = aws_acm_certificate.roboshop.arn
}