terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.7.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region = "eu-west-1"
}
