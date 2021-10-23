provider "aws" {
  region = "us-east-2"
  shared_credentials_file = "~/.aws/credentials"
}

# Credentials are loaded from .env file
provider "newrelic" {}
