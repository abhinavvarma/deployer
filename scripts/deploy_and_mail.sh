#!/usr/bin/env bash

source /home/ubuntu/deployments/deployer/scripts/config.sh

ist=$(TZ=IST-5:30 date)
SUCCESS_MAIL_SUBJECT="Auto-Deployment ($ist): Godavari is successfully redeployed"
FAILURE_MAIL_SUBJECT="Auto-Deployment ($ist): Godavari deployment failed"
MAIL_RECEPIENT="abhinav.varma123@gmail.com"

"$DEPLOYMENT_ROOT/deployer/scripts/deploy.sh" > $DEPLOYMENT_LOG_PATH 2>&1 || {
    echo "Error: Deploy failed";
#    mail -s "$FAILURE_MAIL_SUBJECT" -aFrom:autodep.godavari $MAIL_RECEPIENT < $DEPLOYMENT_LOG_PATH
    exit 1;
}

mail -s "$SUCCESS_MAIL_SUBJECT" -aFrom:autodep.godavari $MAIL_RECEPIENT < $DEPLOYMENT_LOG_PATH
exit 0;

#/home/ubuntu/logs/deployment-watcher.log IN_CLOSE_WRITE /home/ubuntu/deployments/scripts/deploy_root.sh