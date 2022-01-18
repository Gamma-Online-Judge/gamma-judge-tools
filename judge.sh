#!/bin/bash
fileKey=$1
language=$2
templateKey=$3
if [ -z "$fileKey" ] || [ -z "$language" ] || [ -z "$templateKey" ]; then
    echo "Usage: judge.sh <fileKey> <language> <templateKey>"
    exit 1
fi

./mojtools/build-and-test.sh $language s3-bucket/submission_files/$fileKey s3-bucket/templates/$templateKey yes