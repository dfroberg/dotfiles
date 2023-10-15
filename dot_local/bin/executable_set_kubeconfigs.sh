#!/usr/bin/env fish
set FILES $(ls $HOME/.kube/config-*);  eval 'set -gx KUBECONFIG $(echo $FILES|sed "s/ /:/g")'
echo "Merging $KUBECONFIG"
kubectl config view --merge --flatten > $HOME/.kube/config
chmod 600 $HOME/.kube/config
set -gx -x KUBECONFIG "$HOME/.kube/config"
echo "KUBECONFIG is now $KUBECONFIG"
