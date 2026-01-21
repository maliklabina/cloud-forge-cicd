provider "aws" {
  region = "us-east-2"
}

# Create an ECR repository
resource "aws_ecr_repository" "app_repo" {
  name                 = "cloud-forge-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

