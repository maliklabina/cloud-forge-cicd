# S3 Bucket
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.remote_s3.bucket
}

# DynamoDB Table
output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.basic-dynamodb-table.name
}

# EC2 Instances
output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.my_instance[*].id
}

output "instance_public_ips" {
  description = "List of public IP addresses of EC2 instances"
  value       = aws_instance.my_instance[*].public_ip
}

# Security Group 
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.my_security_group.id
}
