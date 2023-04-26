#!/bin/bash

terraform state pull > terraform.tfstat
rm -rf backend.tf .terraform/terraform.tfstat
terraform init # needed after removing backend
terraform destroy --auto-approve
rm -rf backend.tf terraform.* .terraform
