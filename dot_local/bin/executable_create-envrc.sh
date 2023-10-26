#!/bin/bash

REPOS=$(ls -1 -d ~/infura/terraform-aws-eks-cluster*)
for repo in $REPOS; do
  title=$(basename $repo)
  title=${title/terraform-aws-eks-cluster-/}
  if [[ $title == "test-dev" ]]; then
    continue
  fi
  if [[ $title == "template" ]]; then
    continue
  fi
  cd $repo >/dev/null;
  # check if .envrc exists
  echo "Processing $repo";
  if [[ -f .envrc ]]; then
    eval $(cat cluster_infra/terraform.tfvars | sed -e 's/[[:space:]]*//g' -e '/^$/d' -e '/^#/d' -e '/\[/d' -e 's/^/TF_VAR_/')
  else
    TF_VAR_region=us-east-1
  fi
  if [[ -f cluster_infra/terraform.tfvars ]]; then
    if aws sts get-caller-identity --profile infura-$title-env0-deployer-role 2>/dev/null >/dev/null ; then
      profile=infura-$title-env0-deployer-role
    elif aws sts get-caller-identity --profile infura-$title 2>/dev/null >/dev/null ; then
      profile=infura-$title
    else
      echo "  ❌ Failed to setup $title - no profile";
      continue
    fi
    echo "  ✅ Setting profile: $profile";
    cat <<EOF > .envrc
# $title
export AWS_PROFILE=$profile
export AWS_REGION=$TF_VAR_region
export AWS_DEFAULT_REGION=$TF_VAR_region
export KUBECONFIG=$HOME/.kube/config-$title
export EKS_CLUSTER_NAME=$title
EOF
    AWS_PROFILE=$profile
    AWS_REGION=$TF_VAR_region
    AWS_DEFAULT_REGION=$TF_VAR_region
    KUBECONFIG=$HOME/.kube/config-$title
    EKS_CLUSTER_NAME=$title
    echo -n "     "
    timeout 20 aws eks --region $AWS_REGION --profile $AWS_PROFILE update-kubeconfig --name $EKS_CLUSTER_NAME --alias $EKS_CLUSTER_NAME  --kubeconfig $KUBECONFIG;
    if [[ $? -ne 0 ]]; then
      echo "  ❌ Failed to setup kubectl";
    else
      echo "  ✅ Done";
    fi
  cd - >/dev/null;
  fi
    direnv allow >/dev/null;
    # unset AWS_PROFILE;
    # unset AWS_REGION;
    # unset AWS_DEFAULT_REGION;
    # unset KUBECONFIG;
    # unset EKS_CLUSTER_NAME;
done;
