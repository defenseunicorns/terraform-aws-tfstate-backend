variable "region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_prefix" {
  description = "S3 Bucket Prefix"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning on the S3 bucket"
  type        = bool
  default     = true
}

variable "admin_arns" {
  description = "ARNs of IAM users or roles that can administer the bucket. An empty list will allow all principals to administer the bucket."
  type        = list(string)
  default     = []
}

variable "permissions_boundary" {
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = ""
}
