#!/usr/bin/env bash

source /home/ubuntu/deployments/deployer/scripts/config.sh

"$DEPLOYMENT_ROOT/deployer/scripts/build.sh" >> $DEPLOYMENT_LOG_PATH 2>&1 || { echo "Error: Build failed"; exit 1;}
"cd $DEPLOYMENT_PATH" || { echo "Error: Could not cd to $DEPLOYMENT_PATH"; exit 1;}
"./bin/production/deploy.sh" >> $DEPLOYMENT_LOG_PATH 2>&1 || { echo "Error: Deploy failed"; exit 1;}