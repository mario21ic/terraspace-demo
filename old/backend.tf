terraform {
  backend "s3" {
    bucket  = "mario-tmp"
    #encrypt = true
    key     = "tfstate/terraform.tfstate"
    region  = "us-east-2"
  }
}

#terraform {
# backend "gcs" {
#   bucket  = "mario-tfstate"
#   prefix  = "terraform/state"
# }
#}
