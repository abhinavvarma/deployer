#!/usr/bin/env bash
ist=$(TZ=IST-5:30 date)
echo "Build started at $ist"

source /home/ubuntu/deployments/deployer/scripts/config.sh

cd ${DEPLOYMENT_PATH} || { echo "Error: Could not cd to $DEPLOYMENT_PATH"; exit 1;}
if [ "$PWD" == "$DEPLOYMENT_PATH" ]; then
  echo "Location: $PWD"
else
  echo "Could not cd to $DEPLOYMENT_PATH"
  exit 1;
fi
echo "Reverting all local changes"
git reset --hard || { echo "Error: Could not git reset"; exit 1;}
git checkout $DEPLOYMENT_BRANCH || { echo "Error: Could not checkout to $DEPLOYMENT_BRANCH"; exit 1;}
git pull || { echo "Error: Could not pull changes"; exit 1;}
echo "Pull successful"
echo "Following is the commit that is being deployed:"
git log -1
cp $DEPLOYMENT_ROOT/properties.override.json $DEPLOYMENT_PATH/properties/properties.override.json || { echo "Error: Could not copy the properties.override.json"; exit 1;}
echo "Copied the properties.override.json"
"bin/production/setup.sh" || { echo "Error: setup.sh failed"; exit 1; }
exit 0;
