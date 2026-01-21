/*

terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.91.0"
        }
    } 
}


terraform {
  backend "s3" {
    bucket         = "cloud-forge-terraform-state"
    key            = "infra/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_version = ">= 1.4.0"
}
*/


terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }

}





