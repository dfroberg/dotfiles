#!/bin/bash

ORG=${1}" # Your organization in lowercase
CLONE_PATH="/home/dfroberg/$ORG" # Path in your filesystem where you want to clone the repos to
DEFAULT_SUBSET=""
SUBSET="${2:-$DEFAULT_SUBSET}" # Only clone repos that contain this string in their name

# Check if gh is installed
if ! command -v gh &> /dev/null
then
    echo "gh could not be found"
    exit
fi

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found"
    exit
fi

# Check if ORG is set
if [[ -z "$ORG" ]]; then
  echo "Help: clone-repos.sh <ORG> [<SUBSET>,<SUBSET>,<SUBSET>,...]"
  exit
fi
echo "Cloning repos from $ORG to $CLONE_PATH that contain \"$SUBSET\" in their name"
# loop over comma separated list of strings in SUBSET variable and echo the subset
for subset in $(echo $SUBSET | tr "," "\n"); do
  echo "Searching for \"$subset\""
  REPOS=$(gh repo list INFURA --limit 9999 --no-archived --json sshUrl --jq '.[] | select(.sshUrl | contains("'$subset'")) | .sshUrl ')
  for REPO_URL in $REPOS; do
    echo Getting $REPO_URL
    temp=${REPO_URL##*/}
    repo_name=${temp%.*}
    gh repo clone "$REPO_URL" "$CLONE_PATH/$repo_name" -- -q 2>/dev/null || (
        cd "$CLONE_PATH/$repo_name"
        # Handle case where local checkout is on a non-main/master branch
        # - ignore checkout errors because some repos may have zero commits, 
        # so no main or master
        git config pull.rebase true
        git checkout -q main 2>/dev/null || true
        git checkout -q master 2>/dev/null || true
        git fetch -f --tags -q && git pull -q
    )
  done;
done;
