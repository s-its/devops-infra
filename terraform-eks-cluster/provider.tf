terraform {
  backend "s3" {
    bucket         = "devops-anil-terraform-backends"
    dynamodb_table = "state-lock"
    key            = "global/terraform/aws-eks/ap-south-1/state/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}