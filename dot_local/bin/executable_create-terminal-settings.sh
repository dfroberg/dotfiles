#!/bin/bash

echo -n 'new-tab -p "Ubuntu-22.04" --title "Home" --suppressApplicationTitle -d ~ ; '
echo -n 'new-tab -p "Ubuntu-22.04" --title "Home" --suppressApplicationTitle -d ~ ; '
echo -n 'new-tab -p "Ubuntu-22.04" --title "test-dev" --suppressApplicationTitle -d ~/infura/terraform-aws-eks-cluster-test-dev/ ; split-pane -H -p "Ubuntu-22.04" --title "test-dev-tf" --suppressApplicationTitle -d ~/infura/terraform-aws-eks-cluster-test-dev/ ;'
echo -n 'new-tab -p "Ubuntu-22.04" --title "eks-factory" --suppressApplicationTitle -d ~/infura/tfe-eks-workspace-factory/ ; split-pane -H -p "Ubuntu-22.04" --title "eks-factory-tf" --suppressApplicationTitle -d ~/infura/tfe-eks-workspace-factory/ ; '
REPOS=$(ls -1 -d ~/infura/terraform-aws-eks-cluster*)
for repo in $REPOS; do
  title=$(basename $repo)
  title=${title/terraform-aws-eks-cluster-/}
  if [[ $title == "test-dev" ]]; then
    continue
  fi
  if [[ $title == "eks-factory" ]]; then
    continue
  fi
  echo -n 'new-tab -p "Ubuntu-22.04" --title "'$title'" --suppressApplicationTitle -d '$repo' ; split-pane -H -p "Ubuntu-22.04" --title "'$title'-tf" --suppressApplicationTitle -d '$repo' ; '
done;
echo -n "; focus-tab -t 0 ,"
