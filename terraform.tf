terraform {
  required_version = "1.5.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # 5.x
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.2"
    }
  }
}