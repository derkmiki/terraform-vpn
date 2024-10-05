locals {
  owners      = var.department
  environment = var.environment
  name        = "${var.department}-${var.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}