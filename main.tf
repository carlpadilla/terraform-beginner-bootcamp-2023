terraform {
  #  cloud {
  #   organization = "cpadilla"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/random/latest
# resource "random_string" "bucket_name" {
#   length  = 16
#   special = false
#   upper   = false
# }
# S3 Naming rule: https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name
  tags = {
  UserUuid = var.user_uuid
}

}

