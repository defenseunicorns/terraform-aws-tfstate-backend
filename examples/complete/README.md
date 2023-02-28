# Complete Example

This example should create an S3 bucket bucket and DynamoDB table. 

## Example Steps

Standard Terraform Workflow 
1. Checkout this code. 
1. Change Directory to this folder.
1. Ensure AWS CLI is configured (AWS Profile, temporary assume role, or setting environment variable).
1. Change variables in `example.tfvars`.
1. Run `terraform init`.
1. Verify with `terraform plan`.
1. Deploy with `terraform apply`
1. Delete with `terraform delete`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tfstate_backend"></a> [tfstate\_backend](#module\_tfstate\_backend) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

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
