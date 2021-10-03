resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  source     = "../../modules/example"
  bucket     = "terraspace-demo-${var.env}-${random_pet.this.id}"
  acl        = var.acl
}

locals {
  my_helper_value = "<%= my_helper('xD') %>"
}
