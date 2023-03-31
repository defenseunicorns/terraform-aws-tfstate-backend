provider "aws" {
  region = var.region
}

data "aws_partition" "current" {}

module "tfstate_backend" {
  source               = "../.."
  region               = var.region
  bucket_prefix        = var.bucket_prefix
  dynamodb_table_name  = var.dynamodb_table_name
  versioning_enabled   = var.versioning_enabled
  admin_arns           = var.admin_arns
  permissions_boundary = var.permissions_boundary
  logging_bucket_id    = module.s3_bucket_logging[0].s3_bucket_id
}

###S3 Bucket for Logging other S3 Buckets###
data "aws_caller_identity" "current" {}

module "s3_bucket_logging" {
  count   = var.bucket_logging_enabled ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v3.6.0"

  bucket_prefix           = "${var.bucket_prefix}-logging"
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

resource "aws_s3_bucket_versioning" "logging_versioning" {
  count  = var.versioning_enabled ? 1 : 0
  bucket = module.s3_bucket_logging[0].s3_bucket_id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "logging_bucket" {
  bucket = module.s3_bucket_logging[0].s3_bucket_id

  policy = templatefile("../../templates/logging_bucket_bucket_policy.json.tpl", {
    admin_arns            = jsonencode(var.admin_arns)
    s3_bucket_logging_arn = module.s3_bucket_logging[0].s3_bucket_arn
    aws_account_id        = data.aws_caller_identity.current.account_id
  })
}

resource "aws_kms_key" "objects" {
  enable_key_rotation     = true
  description             = "KMS key is used to encrypt bucket objects"
  deletion_window_in_days = 7
  tags                    = var.tags
}
