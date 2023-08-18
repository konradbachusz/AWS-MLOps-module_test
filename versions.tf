terraform {
  required_version = ">= 1.0"

  required_providers {
    archive = "~> 2.4"
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}