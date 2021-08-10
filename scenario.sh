#!/bin/bash
SCENARIO=$1
source ./.env
echo "********** Applying scenario ${SCENARIO} **********"
kubectl apply -f scenario${SCENARIO}.yaml
sleep 3
echo "********** Testing scenario ${SCENARIO} with path **********"
URL="https://anything.${MY_DOMAIN}/web${SCENARIO}"
echo "Calling ${URL}"
curl ${URL}
