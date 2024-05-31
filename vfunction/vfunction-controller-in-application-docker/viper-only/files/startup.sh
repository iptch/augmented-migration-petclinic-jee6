#!/usr/bin/env bash

set -x

echo "Restarting the controller"

bash /tmp/vfunction/opt/vfunction/controller-installation/restart-controller.sh -i default-java || echo "Failed to restart the controller"

while true
do
  sleep 60
done
