#!/bin/bash

# Get generated aws config
AWSCONFIGBLOB=$(~/.local/bin/create-aws-config.sh)

cat <<EOF > ~/.aws/config
$AWSCONFIGBLOB
EOF

aws-sso config-profiles
