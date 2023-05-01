#!/bin/bash

rm -rf .terraform* terraform.tfstate*
terraform init
terraform state pull > terraform.tfstate
cp terraform.tfstate protection.terraform.tfstate
mv backend.tf backend.tf.bk
terraform init -force-copy # needed after removing backend
terraform destroy --auto-approve
rm -rf terraform.tfstate* .terraform
