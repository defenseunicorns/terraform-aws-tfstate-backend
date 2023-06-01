#!/bin/bash


set -x

REGION=$2
PREFIX=$3

function apply() {
    terraform init
    terraform apply --auto-approve
    terraform init -force-copy # copy local state file to s3 and setup s3 as backend
}

function destroy() {
    rm -rf .terraform* terraform.tfstate*
    terraform init 
	rm -rf backend.tf
    #terraform state pull > terraform.tfstate # pull the state from s3 to local file
    #terraform destroy -target=local_file.terraform_backend_config --auto-approve # delete backend.tf config file
    terraform init -force-copy # setup local backend
    terraform destroy --auto-approve
    #rm -rf terraform.tfstate* .terraform*
}

function prep() {

cat <<-VARS > terraform.tfvars
region               = "$REGION"
bucket_prefix        = "$PREFIX"
dynamodb_table_name  = "$PREFIX-lock"
versioning_enabled   = true
admin_arns           = []
permissions_boundary = ""
force_destroy        = true

VARS

cat << 'PROVIDER' > provider.tf
provider "aws" {
region = var.region
}

PROVIDER
}


function cleanup() {
rm -rf terraform.tfvars provider.tf backend.tf .terraform* terraform.tfstate*

}

function get_state() {
	aws ssm get-parameter --region "$REGION" --name "/tfbackend/$PREFIX" --query "Parameter.Value" --output text > backend.tf
}

if [ "$#" -ne 3 ]; then
    echo "Illegal number of parameters. Exactly three arguments are required, action, region and prefix."
	echo 'e.g. "./apply-teardown.sh apply us-east-2 my-resource-prefix."'
    exit 1
fi

case "$1" in

  apply)
    echo "apply stuff"
    prep
    apply
	cleanup
    ;;

  destroy)
    echo "destroy stuff"
	get_state
	prep
    destroy
	#cleanup
    ;;

  test)
    echo "test stuff"
	prep
    apply
	cleanup
	get_state
	prep
    destroy
	cleanup
    ;;

  *)
    cat <<-'EOF'
        Invalid input. usage: ./apply-teardown.sh <action> <region> <prefix> where action is either: 
        "apply", "destroy" or "test" and prefix is the aws resource prefix. 
        e.g. "./apply-teardown.sh apply us-east-2 ".
EOF

    ;;
esac



