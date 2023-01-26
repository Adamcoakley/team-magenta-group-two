terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
    # shared_credentials_files = ["~/.aws/credentials"]
    shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
    region = "eu-west-1"
}
