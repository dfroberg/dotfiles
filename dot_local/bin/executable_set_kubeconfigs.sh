#!/usr/bin/env fish
set FILES $(ls $HOME/.kube/config*);  eval 'export KUBECONFIG=$HOME/.kube/config:$(echo $FILES|sed "s/ /:/g")'
kubectl config view --merge --flatten > $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
