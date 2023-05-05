# terraform-aws-tfstate-backend

Reusable Terraform module that creates a Terraform Remote Backend via AWS S3 and AWS DynamoDB.

This repository contains Terraform configuration files that create various AWS resources, such as an S3 bucket, a DynamoDB table, and KMS keys. These resources are configured to store your terraform TFSTATE files.


## Getting Started

Ensure Terraform is available on the local system and that the AWS CLI has the appropriate credentials put in place.

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
