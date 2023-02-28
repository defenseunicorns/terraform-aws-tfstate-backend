# terraform-aws-tfstate-backend

Reusable Terraform module that creates a Terraform Remote Backend via AWS S3 and AWS DynamoDB.

This repository contains Terraform configuration files that create various AWS resources, such as an S3 bucket, a DynamoDB table, and KMS keys. These resources are configured to hold store your terraform TFSTATE files.


## Getting Started 

Ensure Terraform is available on the local system and that the AWS CLI has the appropriate credentials put in place.
 
### Examples

To view examples for how you can leverage this tfstate-backend Module, please see the [examples](./examples) directory or reference the following example module use.

```terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.2"
}

provider "aws" {
  region = "us-east-2"
}

module "tfstate" {
  source = "git::https://github.com/defenseunicorns/terraform-aws-tfstate-backend.git?ref=main"

  # admin_arns = []
  bucket_prefix       = "zarfinit"
  dynamodb_table_name = "zarfinit"
  # permissions_boundary = 
  region             = "us-east-2"
  versioning_enabled = false

}

output "state_out" {
  value = module.tfstate
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | v3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb_terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_key.dynamo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.backend_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [template_file.backend_bucket_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_arns"></a> [admin\_arns](#input\_admin\_arns) | ARNs of IAM users or roles that can administer the bucket. An empty list will allow all principals to administer the bucket. | `list(string)` | `[]` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | S3 Bucket Prefix | `string` | n/a | yes |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | DynamoDB Table Name | `string` | n/a | yes |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning on the S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfstate_bucket_id"></a> [tfstate\_bucket\_id](#output\_tfstate\_bucket\_id) | Terraform State Bucket Name |
| <a name="output_tfstate_dynamodb_table_name"></a> [tfstate\_dynamodb\_table\_name](#output\_tfstate\_dynamodb\_table\_name) | Terraform State DynamoDB Table Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
