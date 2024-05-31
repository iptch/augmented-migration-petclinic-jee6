#!/usr/bin/env bash

set -x

jvm_args=$(cat /shared/vfunction/etc/sysconfig/vfunction/agent/instances/default-java/vmargs-examples/raw)
export JAVA_TOOL_OPTIONS="$jvm_args"

echo "Running application"
cd /opt/application/lib
jar_name=$(ls -1 *.jar)
java -jar $jar_name
