#!/bin/bash

function apply() {
    terraform init
    terraform apply --auto-approve
    terraform init -force-copy # copy local state file to s3 and setup s3 as backend
}

function destroy() {
    rm -rf .terraform* terraform.tfstate*
    terraform init
    terraform state pull > terraform.tfstate # pull the state from s3 to local file
    terraform destroy -target=local_file.terraform_backend_config --auto-approve # delete backend.tf config file
    terraform init -force-copy # setup local backend
    terraform destroy --auto-approve
    rm -rf terraform.tfstate* .terraform*
}

apply
destroy
