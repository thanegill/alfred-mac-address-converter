#! /usr/bin/env bash
set -e

source bash-workflow-handler/workflowHandler.sh

MAC=$1

function addMAC() {
    lower=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    upper=$(echo "$1" | tr '[:lower:]' '[:upper:]')

    if [[ $MAC != $lower ]]; then
        addResult $lower $lower $lower
    fi

    if [[ $MAC != $upper ]]; then
        addResult $upper $upper $upper
    fi
}

MAC=${MAC//:}
MAC=${MAC//-}

addMAC $MAC

addMAC ${MAC:0:2}:${MAC:2:2}:${MAC:4:2}:${MAC:6:2}:${MAC:8:2}:${MAC:10:2}
addMAC ${MAC:0:2}-${MAC:2:2}-${MAC:4:2}-${MAC:6:2}-${MAC:8:2}-${MAC:10:2}

getXMLResults
