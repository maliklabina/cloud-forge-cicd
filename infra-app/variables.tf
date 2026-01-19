variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "bucket_name" {
  description = "S3 bucket name for app artifacts"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}


variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}


variable "ec2_ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
  
}


variable "hash_key" {
    description = "Hash key for DynamoDB table"
    type        = string
  
}

