#!/bin/bash

PRIVATE_KEY_PATH=$(pwd)/id_rsa
CURRENT_PATH=$(pwd)
KUBECONFIG=kubeconfig

if [ $# -ne "1" ]; then
    echo "Arguments <init|plan|apply|destroy> are required!!!"
    exit 1
fi

if [ -f "${PRIVATE_KEY_PATH}" ]; then
    echo "File [${PRIVATE_KEY_PATH}] already exist, skip creating it!!!"
else
    echo "Create file [${PRIVATE_KEY_PATH}]"
    ssh-keygen -f ${PRIVATE_KEY_PATH} -N ""
fi

OPERATION=$1
terragrunt run-all ${OPERATION}
EXIT_CODE=$?

if [ ${EXIT_CODE} -eq 0 ]; then
    if [ ${OPERATION} = 'apply' ]; then
        cd 02-1-rke-cluster; terraform output kube_config_yaml > ${CURRENT_PATH}/${KUBECONFIG}.out; cd -
        LINECOUNT=$(cat ${KUBECONFIG}.out | wc -l)
        let "TOLINE=${LINECOUNT}-1"
        sed -ne "2,${TOLINE}p" ${KUBECONFIG}.out > ${KUBECONFIG}
    fi    
fi
