#!/bin/bash

# Checks
if ! command -v aws-sso &> /dev/null
then
    echo "aws-sso could not be found"
    exit
fi
if ! command -v aws &> /dev/null
then
    echo "aws could not be found"
    exit
fi
if [ -z "$REPOROOT" ]; then
    echo "REPOROOT is not set, ensure you have created the .envrc file as described in https://github.com/infura/terraform-aws-eks-cluster-test-dev/blob/679099584d5b4ffc5e9469e8757107f9c054e8d9/bin/README.md"
    exit
fi
# Get generated aws config
AWSCONFIGBLOB=$(~/.local/bin/create-aws-config.sh)

cat <<EOF > ~/.aws/config
$AWSCONFIGBLOB
EOF

aws-sso config-profiles
