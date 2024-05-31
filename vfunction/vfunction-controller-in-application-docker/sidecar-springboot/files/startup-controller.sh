#!/usr/bin/env bash

set -x

echo "Starting the controller"

bash /shared/vfunction/opt/vfunction/controller/instances/default-java/bin/vf-controller start || echo "Failed to start the controller"
