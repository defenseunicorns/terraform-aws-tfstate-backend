output "tfstate_bucket_id" {
  value       = module.tfstate_backend.tfstate_bucket_id
  description = "Terraform State Bucket Name"
}

output "s3_logging_bucket_id" {
  value       = module.s3_bucket_logging[0].s3_bucket_id
  description = "S3 Logging Bucket Name"
}

output "tfstate_dynamodb_table_name" {
  value       = module.tfstate_backend.tfstate_dynamodb_table_name
  description = "Terraform State DynamoDB Table Name"
}
