terraform {
  backend "s3" {
    bucket  = "mario-tmp"
    #encrypt = true
    key     = "tfstate/terraform.tfstate"
    region  = "us-east-2"
  }
}

