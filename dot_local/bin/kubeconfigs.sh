#!/bin/env fish
set FILES $(ls $HOME/.kube/config*);  eval 'export KUBECONFIG=$HOME/.kube/config:$(echo $FILES|sed "s/ /:/g")'
