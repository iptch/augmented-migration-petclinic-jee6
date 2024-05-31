#!/usr/bin/env bash

set -x

echo "Moving controller files to shared folder"
mv /tmp/vfunction /shared/
mkdir /shared/binaries-for-viper
