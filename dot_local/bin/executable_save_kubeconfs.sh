#!/usr/bin/env bash
# Save current KUBECONFIGs to a op
eval $(pass my.1password.com/danny.froberg@consensys.net | op signin)
KUBEFILES="$HOME/.kube/config*"
IFS=$'\n' #for in $() splits based on IFS
for entry in $(ls $KUBEFILES | grep "config-" | grep -v ".bak" | grep -v ".tmp")
do
    FULLPATH="$entry"
    OPPATH=$(echo $entry | sed "s|$HOME/||")
    echo "Saving $FULLPATH $OPPATH"
    cat $FULLPATH | op document edit $OPPATH
    if [ $? -eq 0 ]; then
        echo "> Saved $FULLPATH to $OPPATH"
    else
        echo "> Failed to save $FULLPATH to $OPPATH"
        echo "> Trying to create $OPPATH"
        op document create $FULLPATH --vault Private --tags chezmoi --title $OPPATH
        if [ $? -eq 0 ]; then
            echo "> Created $FULLPATH at $OPPATH"
        else
            echo "> Failed to create $OPPATH"
        fi
    fi
done
op signout
