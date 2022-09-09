#!/usr/bin/env bash
# Restore current KUBECONFIGs to from OP
eval $(pass my.1password.com/danny.froberg@consensys.net | op signin)
KUBEFILES=$(op --vault=Private document list | grep ".kube/config-" | grep -v ".bak" | awk '{print $2}')
IFS=$'\n' #for in $() splits based on IFS
for entry in $KUBEFILES
do
    FULLPATH="$HOME/$entry"
    OPPATH=$entry
    echo "Restoring $OPPATH -> $FULLPATH"
    op document get $OPPATH > $FULLPATH
    if [ $? -eq 0 ]; then
        echo "> Saved $OPPATH to $FULLPATH"
    else
        echo "> Failed to save $OPPATH to $FULLPATH"
    fi
done
op signout
kubeconfigs.sh
kubectl config view --merge --flatten > $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
