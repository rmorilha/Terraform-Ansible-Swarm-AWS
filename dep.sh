#!/bin/bash

if [ -z "$1" ] 
then
  echo "################## Informe o diretório e ação do terraform ! ######################"
  echo "sh dep.sh [TERRAFORM_DIR] [destroy|init|plan|apply]"
  exit 1
fi

# AWS keys
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""

# AWS regions
export AWS_DEFAULT_REGION="eu-central-1"

cd $1
terraform $2

