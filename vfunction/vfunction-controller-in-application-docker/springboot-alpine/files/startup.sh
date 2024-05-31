#!/usr/bin/env sh

set -x

echo "Restarting the controller"

sh /tmp/vfunction/opt/vfunction/controller-installation/restart-controller.sh -i default-java || echo "Failed to restart the controller"

jvm_args=$(cat /tmp/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/raw)
export JAVA_TOOL_OPTIONS="$jvm_args"

echo "Running application"
cd /opt/application/lib
jar_name=$(ls -1 *.jar)
java -jar $jar_name
