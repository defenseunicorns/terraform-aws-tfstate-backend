#!/bin/bash

function get_plan_output() {
    terraform init
    terraform plan -out plan.json
    terraform show -json plan.json | jq > pretty_plan.json
    rm plan.json
}

function apply() {
    terraform init
    terraform apply --auto-approve
    terraform init -force-copy
}

function destroy() {
    rm -rf .terraform* terraform.tfstate*
    terraform init
    terraform state pull > terraform.tfstate
    terraform destroy -target=local_file.terraform_backend_config --auto-approve
    terraform init -force-copy # needed after removing backend
    terraform destroy --auto-approve
    rm -rf terraform.tfstate* .terraform terraform.tfvars pretty_plan.json
}

get_plan_output
apply
destroy