#!/bin/sh

# Preparation
SSM_SERVICE_ROLE_NAME="sbcntr-SSMServiceRole"
SSM_ACTIVATION_FILE="code.json"
#AWS_REGION="eu-west-1"
AWS_REGION="ap-northeast-2"

# Create Activation Code on Systems Manager
aws ssm create-activation \
--description "Activation Code for Fargate Bastion" \
--default-instance-name bastion \
--iam-role ${SSM_SERVICE_ROLE_NAME} \
--registration-limit 1 \
--tags Key=Type,Value=Bastion \
--region ${AWS_REGION} | tee ${SSM_ACTIVATION_FILE}

SSM_ACTIVATION_ID=`cat ${SSM_ACTIVATION_FILE} | jq -r .ActivationId`
SSM_ACTIVATION_CODE=`cat ${SSM_ACTIVATION_FILE} | jq -r .ActivationCode`
rm -f ${SSM_ACTIVATION_FILE}

# Activate SSM Agent on Fargate Task
amazon-ssm-agent -register -code "${SSM_ACTIVATION_CODE}" -id "${SSM_ACTIVATION_ID}" -region ${AWS_REGION}

# Delete Activation Code
aws ssm delete-activation --activation-id ${SSM_ACTIVATION_ID}
rm -rf /var/lib/amazon/ssm/ipc/*
# Execute SSM Agent
amazon-ssm-agent