terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.64.0"
    }
  }

  required_version = "~> 1.9.2"

  backend "s3" {
    bucket         = "terraform-vpn-eaf"             # change this to your own bitbucket repo
    key            = "dev/aws-vpn/terraform.tfstate" #change this to your own key
    region         = "us-east-1"
    dynamodb_table = "dev-awsvpn" #change this to your own table
  }
}

provider "aws" {
  region = var.aws_region
}