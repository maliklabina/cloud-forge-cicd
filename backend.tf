terraform {
  backend "s3" {
    bucket = "cloud-forge-terraform-state"
    key    = "state/terraform.tfstate"
    region = "us-east-2"
  }
}
