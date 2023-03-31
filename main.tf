locals {
  create_bucket_policy = length(var.admin_arns) > 0 ? true : false
}

data "aws_partition" "current" {}

resource "aws_kms_key" "objects" {
  enable_key_rotation     = true
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
  tags                    = var.tags
}
resource "aws_kms_key" "dynamo" {
  enable_key_rotation     = true
  description             = "KMS key is used to encrypt dynamodb table"
  deletion_window_in_days = 7
  tags                    = var.tags
}

resource "aws_dynamodb_table" "dynamodb_terraform_state_lock" {
  name         = "${var.dynamodb_table_name}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  point_in_time_recovery {
    enabled = true
  }
  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.dynamo.arn
  }

  tags = var.tags
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v3.6.0"

  bucket_prefix           = var.bucket_prefix
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  force_destroy = var.force_destroy
  tags          = var.tags
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = aws_kms_key.objects.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  count  = var.versioning_enabled ? 1 : 0
  bucket = module.s3_bucket.s3_bucket_id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "logging" {
  count  = var.bucket_logging_enabled ? 1 : 0
  bucket = module.s3_bucket.s3_bucket_id

  target_bucket = var.logging_bucket_id
  target_prefix = "log/"
}

resource "aws_s3_bucket_policy" "backend_bucket" {
  count  = local.create_bucket_policy ? 1 : 0
  bucket = module.s3_bucket.s3_bucket_id

  policy = templatefile("${path.module}/templates/backend_bucket_bucket_policy.json.tpl", {
    admin_arns    = jsonencode(var.admin_arns)
    s3_bucket_arn = module.s3_bucket.s3_bucket_arn
  })
}
