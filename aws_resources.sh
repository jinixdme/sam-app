#!/bin/bash

BUCKET_NAME=$1

# Branch has to be protected
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-eu-central-1}

bucket_exists () {
  status=$(aws s3 ls 2>&1 | grep $1)
  if [ -n "$status" ]; then echo true; else echo ''; fi
}

create_bucket () {
  if [ -z $(bucket_exists $BUCKET_NAME) ]
  then
    echo "Create bucket $BUCKET_NAME in region $AWS_DEFAULT_REGION"
    result=$(aws s3api create-bucket --bucket $BUCKET_NAME --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION 2>&1)
    echo $result
  else
    echo "Bucket $BUCKET_NAME exists"
  fi
}

create_bucket
