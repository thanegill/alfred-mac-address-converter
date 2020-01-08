#! /usr/bin/env bash
set -e

source bash-workflow-handler/workflowHandler.sh

ORIGINAL_MAC=$1

function addMAC() {
    lower=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    upper=$(echo "$2" | tr '[:lower:]' '[:upper:]')

    # Add lower case if diffrent that original
    if [[ $ORIGINAL_MAC != $lower ]]; then
        addResult $lower $lower $lower "Lowercase $1"
    fi

    # Add upper case if diffrent that original
    if [[ $ORIGINAL_MAC != $upper ]]; then
        addResult $upper $upper $upper "Uppercase $1"
    fi
}

# Remove : and - demilinators
CLEAN_MAC=$(echo $ORIGINAL_MAC | tr -cd '[:xdigit:]')

if [ ${#CLEAN_MAC} != 12 ]; then
    addResult "Not a vaild MAC address" "Not a vaild MAC address" "Not a vaild MAC address"
    getXMLResults
fi

# Add case change first with same deliminators
addMAC "orginal" $ORIGINAL_MAC
# Add MAC with colon deliminator every 2 characters
addMAC "with colons" ${CLEAN_MAC:0:2}:${CLEAN_MAC:2:2}:${CLEAN_MAC:4:2}:${CLEAN_MAC:6:2}:${CLEAN_MAC:8:2}:${CLEAN_MAC:10:2}
# Add MAC with hyphen deliminator every 2 characters
addMAC "with hyphens" ${CLEAN_MAC:0:2}-${CLEAN_MAC:2:2}-${CLEAN_MAC:4:2}-${CLEAN_MAC:6:2}-${CLEAN_MAC:8:2}-${CLEAN_MAC:10:2}
# Add MAC with sigle hyphen deliminator in the middle
addMAC "with middle hyphen" ${CLEAN_MAC:0:6}-${CLEAN_MAC:6:6}
# Add MAC with no deliminators
addMAC "with no deliminators" $CLEAN_MAC

getXMLResults
