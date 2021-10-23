resource "random_pet" "this" {
  keepers = {
    user = var.user
    pass = var.pass
  }
}

locals {
    KeyFromOtherStack = var.KeyFromOtherStack
}
