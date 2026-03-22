module "backend" {
      for_each = var.components
      source = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
      component = each.key
      rule_priority = each.value.rule_priority
      environment = var.environment
    }
# module "catalogue" {
#   source        = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
#   component     = "catalogue"
#   rule_priority = var.components["catalogue"].rule_priority
# }

# module "user" {
#   source        = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
#   component     = "user"
#   rule_priority = var.components["user"].rule_priority
#   depends_on    = [module.catalogue]
# }

# module "cart" {
#   source        = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
#   component     = "cart"
#   rule_priority = var.components["cart"].rule_priority
#   depends_on    = [module.user]
# }

# module "shipping" {
#   source        = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
#   component     = "shipping"
#   rule_priority = var.components["shipping"].rule_priority
#   depends_on    = [module.cart]
# }

# module "payment" {
#   source        = "git::https://github.com/gowthambabu8/terraform-roboshop-component.git?ref=main"
#   component     = "payment"
#   rule_priority = var.components["payment"].rule_priority
#   depends_on    = [module.shipping]
# }