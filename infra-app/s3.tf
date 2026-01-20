resource "aws_s3_bucket" "remote_s3" {
    bucket = "${var.env}-${var.bucket_name}"  
    
    tags = {
        Name        = "${var.env}-${var.bucket_name}" 
        Environment = var.env
    }
  
}

resource "aws_s3_bucket" "docker_images" {
  bucket = "cloud-forge-app-images"

  tags = {
    Name        = "cloud-forge-app-images"
    Environment = "shared"
  }
}
