terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  #  shared_config_files = "/home/danielsepulvida/.aws/config_personal"
  #  shared_credentials_files = "/home/danielsepulvida/.aws/credentials"
  #  profile                 = "homelab" 
}