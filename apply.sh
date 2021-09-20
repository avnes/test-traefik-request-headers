#!/bin/bash
echo "********** Applying namespace **********"
kubectl apply -f ns.yaml
./scenario.sh 01
./scenario.sh 02
./scenario.sh 03
