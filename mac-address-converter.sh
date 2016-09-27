#! /usr/bin/env bash
set -e

source bash-workflow-handler/workflowHandler.sh

function addMAC() {
    addResult $1 $1 $1
}

MAC=$1

if [[ $MAC == *":"* ]]; then
    addMAC ${MAC//:}
    addMAC ${MAC//:/-}
fi

if [[ $MAC == *"-"* ]]; then
   addMAC ${MAC//-}
   addMAC ${MAC//-/:}
fi

if [[ ${#MAC} == 12 ]]; then
    addMAC ${MAC:0:2}:${MAC:2:2}:${MAC:4:2}:${MAC:6:2}:${MAC:8:2}:${MAC:10:2}
fi


if [[ ${#MAC} == 12 ]]; then
    addMAC ${MAC:0:2}-${MAC:2:2}-${MAC:4:2}-${MAC:6:2}-${MAC:8:2}-${MAC:10:2}
fi


getXMLResults
