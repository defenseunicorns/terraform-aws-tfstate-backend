!#/bin/bash

terraform init
terraform apply --auto-approve
terraform init -force-copy
