#!/usr/bin/env bash

set -x

echo "Restarting the controller"
bash /tmp/vfunction/opt/vfunction/controller-installation/restart-controller.sh -i default-java || echo "Failed to restart the controller"

echo "Running application"
/opt/ibm/helpers/runtime/docker-server.sh

exec "$@"

sleep 10000000
