output "tfstate_bucket_id" {
  value       = module.s3_bucket.s3_bucket_id
  description = "Terraform State Bucket Name"
}

output "s3_logging_bucket_id" {
  value       = module.s3_bucket_logging.s3_bucket_id
  description = "S3 Logging Bucket Name"
}

output "tfstate_dynamodb_table_name" {
  value       = aws_dynamodb_table.dynamodb_terraform_state_lock.name
  description = "Terraform State DynamoDB Table Name"
}
