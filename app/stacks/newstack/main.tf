resource "random_pet" "this" {
  length = 2
}

module "bucket" {
  #source     = "../../modules/example" # using app/modules
  #source     = "terraform-aws-modules/s3-bucket/aws" # Terraform registry
  source     = "../../../../../vendor/modules/s3" # using modules provided by Terrafile
  bucket     = "terraspace-newstack-${random_pet.this.id}"
  acl        = var.acl
}
