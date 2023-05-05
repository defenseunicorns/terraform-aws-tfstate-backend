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
Destroying the environment with Terraform requires a few more steps than usual. This is due to the state file being in the remote bucket.

1. Copy the state file locally with `terraform state pull > terraform.state`
1. Move the backend out of scope `mv backend.tf backend.tf.bk`
1. Run the init again `terraform init -force-copy`
1. Finally destroying resources with `terraform destroy -auto-approve`
1. The S3 bucket may not be deleted and may have to be manually emptied before deletion. Ensure the state file has been bulled prior to clearing the bucket.

## Terraform docs

See [Terraform Docs](./terraform-docs.md) for detailed documentation
