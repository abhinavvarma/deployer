#!/usr/bin/env bash

DIR=$( dirname "${BASH_SOURCE[0]}" )
ROOT="$DIR/.."

ALL_RESULTS=$(python -c "import imp;settings = imp.load_source('settings', '$ROOT/settings.py');print settings.BRANCH_TO_WATCH")

DEPLOYMENT_ROOT="/home/ubuntu/deployments"
DEPLOYMENT_FOLDER="godavari"
DEPLOYMENT_PATH=${DEPLOYMENT_ROOT}"/"${DEPLOYMENT_FOLDER}
DEPLOYMENT_LOG_PATH="/home/ubuntu/logs/deployment.log"
DEPLOYMENT_BRANCH=$(echo $ALL_RESULTS | cut -d' ' -f1)

echo $DEPLOYMENT_BRANCH
