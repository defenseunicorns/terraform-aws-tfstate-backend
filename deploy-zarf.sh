#!/bin/bash

# Check the processor architecture
if [[ $(uname -m) == "x86_64" ]]; then
  echo "The processor architecture is 64-bit"
  ARCH_PROC=amd64
elif [[ $(uname -m) == "i686" || $(uname -m) == "i386" ]]; then
  echo "The processor architecture is 32-bit"
  echo "The processor is not AMD or ARM"
elif [[ $(uname -m) == "arm64" ]]; then
  ARCH_PROC=arm64
else
# default...
  ARCH_PROC=amd64
fi

zarf package deploy zarf-package-terraform-aws-tfstate-backend-${ARCH_PROC}.tar.zst \
	--set region="us-east-2" \
	--set bucket_prefix="exampletfstate-" \
	--set versioning_enabled="false" \
	--set force_destroy="true" \
	--components backend \
	--confirm

