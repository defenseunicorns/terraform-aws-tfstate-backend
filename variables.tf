variable "region" {
  description = "AWS Region"
  type        = string
}

variable "bucket" {
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket."
  type        = string
  default     = null
}

variable "dynamodb_table_name" {
  description = "DynamoDB Table Name"
  type        = string
  default     = null
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

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign kms and bucket resources."
  type        = map(string)
  default     = {}
}

variable "generate_backend_file" {
  description = "Boolean variable for whether ir not to generate a backend.tf file"
  type        = bool
  default     = false
}

variable "generate_ssm_parameter" {
  description = "Boolean variable for whether or not to generate a parameter store entry of the backend.tf file"
  type        = bool
  default     = false
}