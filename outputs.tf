

# DEV Environment

output "dev_s3_bucket_name" {
  value = module.dev_infra.s3_bucket_name
}

output "dev_dynamodb_table_name" {
  value = module.dev_infra.dynamodb_table_name
}

output "dev_instance_ids" {
  value = module.dev_infra.instance_ids
}

output "dev_instance_public_ips" {
  value = module.dev_infra.instance_public_ips
}

output "dev_security_group_id" {
  value = module.dev_infra.security_group_id
}

# PROD Environment

output "prod_s3_bucket_name" {
  value = module.prod_infra.s3_bucket_name
}

output "prod_dynamodb_table_name" {
  value = module.prod_infra.dynamodb_table_name
}

output "prod_instance_ids" {
  value = module.prod_infra.instance_ids
}

output "prod_instance_public_ips" {
  value = module.prod_infra.instance_public_ips
}

output "prod_security_group_id" {
  value = module.prod_infra.security_group_id
}



