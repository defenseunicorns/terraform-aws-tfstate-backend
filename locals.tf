locals {
  create_bucket_policy = length(var.admin_arns) > 0 ? true : false
  backend_content = {
    region               = var.region
    bucket               = module.s3_bucket.s3_bucket_id
    terraform_state_file = "tfstate/${var.region}/${module.s3_bucket.s3_bucket_id}-bucket.tfstate"
    dynamodb_table       = aws_dynamodb_table.dynamodb_terraform_state_lock.id
  }
}
