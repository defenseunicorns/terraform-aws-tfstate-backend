output "tfstate_bucket_id" {
  value       = module.tfstate_backend.tfstate_bucket_id
  description = "Terraform State Bucket Name"
}

#TODO: Remove this comment that's used for testing ci flows

output "tfstate_dynamodb_table_name" {
  value       = module.tfstate_backend.tfstate_dynamodb_table_name
  description = "Terraform State DynamoDB Table Name"
}
