#!/bin/bash

sudo $(which chef) exec rake ci

## Obtain the source AMI to use for our Packer build.
base_ami_id=$(aws ec2 describe-images --filters Name=tag-key,Values=ami Name=tag-value,Values=aws-ubuntu-base --output text --query 'Images[0].ImageId')

## Build an AMI for this cookbook
$(which chef) exec rake packer[$base_ami_id]
