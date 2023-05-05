# Complete Example

This example should create an S3 bucket and DynamoDB table.

## Example Steps

**Standard Terraform Workflow**
This is how to provision the S3 bucket and DynamoDB table, then push the local state file to the bucket and use matched lock file.

1. Checkout this code.
1. Change directory to this folder.
1. Ensure AWS CLI is configured (AWS Profile, temporary assume role, or setting environment variable).
1. Change variables in `example.tfvars`.
1. Run `terraform init`.
1. Verify with `terraform plan`
1. Deploy with `terraform apply`
1. Push local state file to bucket with `terraform init -force copy`
1. Validate if you need, but there will now be a new copy of the backend called `backend.tf`. Do not lose this file. The bucket and table should be reused for future deployments.

**Destroying resources**
Destroying the environment with Terraform requires a few more steps than ususal. This is due to the state file being in the remote bucket.

1. Copy the state file locally with `terraform state pull > terraform.state`
1. Move the backend out of scope `mv backend.tf backend.tf.bk`
1. Run the init again `terraform init -force-copy`
1. Finally destroying resources with `terraform destroy -auto-approve`
1. The S3 bucket may not be deleted and may have to be manually emptied before deletion. Ensure the state file has been bulled prior to clearing the bucket.

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
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | n/a | yes |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning on the S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tfstate_bucket_id"></a> [tfstate\_bucket\_id](#output\_tfstate\_bucket\_id) | Terraform State Bucket Name |
| <a name="output_tfstate_dynamodb_table_name"></a> [tfstate\_dynamodb\_table\_name](#output\_tfstate\_dynamodb\_table\_name) | Terraform State DynamoDB Table Name |
<!-- END_TF_DOCS -->
