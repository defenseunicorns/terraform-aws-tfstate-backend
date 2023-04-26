#!/bin/bash
# This script assumes terraform apply has been completed already creating an S3 bucket and DynamoDB table.

# Read from the state file to get outputs and save in variables

table=$(jq '.outputs.lock_table.value' terraform.tfstate -r)
bucket=$(jq '.outputs.tfbucket.value' terraform.tfstate -r)
localName=${table::-6}
thisRegion=$(jq '.resources[] | select(.name == "tfbucket")| .instances[].attributes.region' terraform.tfstate -r)

# First write backend
cat << EOL > backend.tf
terraform {
  backend "s3" {
    bucket         = "${bucket}"
    key            = "statefiles/${thisRegion}/${localName}.tfstate"
    region         = "${thisRegion}"
    dynamodb_table = "${table}"
  }
}
EOL

# Finally, rerun init so the s3 backend is set and state file is moved
terraform init -migrate-state -force-copy
