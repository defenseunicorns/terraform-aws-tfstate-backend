# terraform-aws-tfstate-backend

Reusable Terraform module that creates a Terraform Remote Backend via AWS S3 and AWS DynamoDB.

This repository contains Terraform configuration files that create various AWS resources, such as an S3 bucket, a DynamoDB table, and KMS keys. These resources are configured to store your terraform TFSTATE files.


## Getting Started

Ensure Terraform is available on your local system and that the AWS CLI has the appropriate credentials put in place.

### Examples

To view examples of how you can leverage this tfstate-backend Module, please see the [examples](./examples) directory.

### Testing

- `make test` will execute the tests the same way they run in CI
- `make run-pre-commit-hooks` will run linting and formatting checks and will fix most errors automatically.

If opening a PR, opening it in `draft` status will prevent the CI tests from running automatically. This will prevent executing tests that generate real AWS resources on every push until the PR is ready to review.

### Testing

- `make test` will execute the tests the same way they run in CI
- `make run-pre-commit-hooks` will run linting and formatting checks and will fix most errors automatically.

If opening a PR, opening it in `draft` status will prevent the CI tests from running automatically. This will prevent executing tests that generate real AWS resources on every push until the PR is ready to review.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | v3.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.dynamodb_terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_kms_key.dynamo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.backend_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [local_file.terraform_backend_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_arns"></a> [admin\_arns](#input\_admin\_arns) | ARNs of IAM users or roles that can administer the bucket. An empty list will allow all principals to administer the bucket. | `list(string)` | `[]` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | S3 Bucket Prefix | `string` | n/a | yes |
| <a name="input_create_backend_file"></a> [create\_backend\_file](#input\_create\_backend\_file) | (Optional, Default:true) If true, creates a backend.tf file automatically | `bool` | `true` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | DynamoDB Table Name | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign kms and bucket resources. | `map(string)` | `{}` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning on the S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfstate_bucket_id"></a> [tfstate\_bucket\_id](#output\_tfstate\_bucket\_id) | Terraform State Bucket Name |
| <a name="output_tfstate_dynamodb_table_name"></a> [tfstate\_dynamodb\_table\_name](#output\_tfstate\_dynamodb\_table\_name) | Terraform State DynamoDB Table Name |
<!-- END_TF_DOCS -->
