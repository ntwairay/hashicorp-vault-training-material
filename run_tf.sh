#!/bin/bash
export AWS_DEFAULT_REGION=us-west-1

# Setup path
readonly DIR=$(cd `dirname $0` && pwd)
readonly TERRAFORM_PATH="terraform"
readonly ENVIRONMENT_PATH="environment/example"
readonly FOUNDATION_PATH="aws-foundation"
readonly VAULT_CLUSTER_PATH="vault-auto-unseal"
readonly VPC_PEERING_PATH="aws-vpcpeering"
readonly PEERING_ROUTE_PATH="aws-vpcpeering-route"
readonly STATE_PATH=".terraform/terraform.tfstate"
readonly REGION1="uswest1"
readonly REGION2="uswest2"
# run terraform init
function terraform_init {
  echo "Running terraform init at $STACK ʘ‿ʘ !!!"
  terraform init -backend-config="key=$STACK-$REGION"
}
# deploy terraform
function terraform_execute {
  echo "Running terraform $COMMAND at $REGION/$STACK ᕕ(ᐛ)ᕗ !!!"
  terraform $COMMAND -var-file="$DIR/$ENVIRONMENT_PATH/$REGION/$STACK/terraform.tfvars" -auto-approve
}
# clean up tfstate file
function terraform_cleanup {
  echo "Removing terraform.tfstate in $STACK ʘ‿ʘ !!!"
  rm ./$STATE_PATH
  echo "(☞ﾟヮﾟ)☞ task is done ☜(ﾟヮﾟ☜)"
}

# deploy aws foundation such as VPC, Subnets, NAT and IG etc
function deploy_aws_foundation {
  local -r REGION="$1"
  local -r STACK="$FOUNDATION_PATH"
  cd "$DIR/$TERRAFORM_PATH/$STACK"
  terraform_init
  terraform_execute
  terraform_cleanup
}
# deploy aws vpc peering
function deploy_aws_vpc_peering {
  local -r REGION="$1"
  local -r STACK="$VPC_PEERING_PATH"
  cd "$DIR/$TERRAFORM_PATH/$STACK"
  terraform_init
  terraform_execute
  terraform_cleanup
}
# deploy peering route
function deploy_aws_peering_route {
  local -r REGION="$1"
  local -r STACK="$PEERING_ROUTE_PATH"
  cd "$DIR/$TERRAFORM_PATH/$STACK"
  terraform_init
  terraform_execute
  terraform_cleanup
}
# deploy vault cluster
function deploy_vault_cluster {
  local -r REGION="$1"
  local -r STACK="$VAULT_CLUSTER_PATH"
  cd "$DIR/$TERRAFORM_PATH/$STACK"
  terraform_init
  terraform_execute
  terraform_cleanup
}

function run {
  local apply="false"
  local destroy="false"
  local all="false"

  local command="$1"
  shift

  while [[ $# > 0 ]]; do
    local key="$1"

    case "$key" in
      --all)
        all="true"
        ;;
      #--destroy)
      #  destroy="true"
      #  exit
      #  ;;
      *)
        echo "Unrecognized argument: $key"
        #print_usage
        exit 1
        ;;
    esac

    shift
  done

  if [["$command" != "--apply" || "$command" != "--destroy" ]]; then
    echo "Unrecognized argument"
  else
    if [[ "$command"  == "--apply" && "$all"  == "true" ]]; then
      $COMMAND="apply"
      deploy_aws_foundation $REGION1
      deploy_aws_foundation $REGION2
      deploy_aws_vpc_peering $REGION1
      deploy_aws_peering_route $REGION1
      deploy_aws_peering_route $REGION2
      deploy_vault_cluster $REGION1
      deploy_vault_cluster $REGION2
    fi
    if [[ "$command"  == "--destroy" && "$all"  == "true" ]]; then
      $COMMAND="destroy"
      deploy_vault_cluster $REGION1
      deploy_vault_cluster $REGION2
      deploy_aws_vpc_peering $REGION1
      deploy_aws_peering_route $REGION1
      deploy_aws_peering_route $REGION2
      deploy_aws_foundation $REGION1
      deploy_aws_foundation $REGION2
    fi
  fi
}

run "$@"
