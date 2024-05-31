#!/usr/bin/env sh
netstat -nlp | grep 8080 | grep tcp | grep -q LISTEN
exit $?
