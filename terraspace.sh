#!/bin/bash
# usage:   aws_region environment command stack
# examples: 
# us-east-1 dev up demo
# us-east-1 prod seed newstack
# us-east-2 test all up

#export AWS_REGION=$1
#export TS_ENV=$2
#shift
#shift

CMD="bundle exec terraspace $@"
echo "AWS_REGION="$AWS_REGION
echo "TS_ENV="$TS_ENV
echo "CMD: "$CMD
eval $CMD
