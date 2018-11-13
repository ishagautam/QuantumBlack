#!/bin/bash

die() {
  echo >&2 "$@"
  exit 1
}

TFSTATE_BUCKET=$1
KEYNAME=$2

if [[ -z "$TFSTATE_BUCKET" ]]; then
  die "Pass the bucket name parameter."
fi

if [[ -z "$KEYNAME" ]]; then
  die "Pass the bucket keyname."
fi

echo "#####################################################################################"
echo ""
echo "Initializing the remote state: $KEYNAME in S3:$TFSTATE_BUCKET"
echo ""
echo "#####################################################################################"

terraform init -backend=true -backend-config "access_key=$AWS_ACCESS_KEY_ID" -backend-config "secret_key=$AWS_SECRET_ACCESS_KEY" -backend-config "region=us-west-2" -backend-config "bucket=$TFSTATE_BUCKET" -backend-config "key=$KEYNAME" -backend-config "encrypt=1"
