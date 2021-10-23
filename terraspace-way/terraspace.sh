#!/bin/bash
CMD="bundle exec terraspace $@"
echo "AWS_REGION="$AWS_REGION
echo "TS_ENV="$TS_ENV
echo "CMD: "$CMD
eval $CMD
