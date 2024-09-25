#!/bin/bash
#
#

#######################################
# Author: Somesh Teja Yerramsetty
# Date: Sep 25, 2024
# Version: V1
#######################################

# This script is to retrieve AWS Resource usages

set -exo pipefail # For debug, error, and also pipefail mode

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

# This command is to use to list all the S3 buckets
echo "Print list of S3 buckets"
aws s3 ls

# List EC2 instances and filtering with InstanceID's only
echo "Print list of EC2 Instances"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# List AWS Lambda functions
echo "Print list of Lambda-function"
aws lambda list-functions

# List IAM Users
echo "Print list of IAM Users"
aws iam list-users | jq '.Users[].UserName'
