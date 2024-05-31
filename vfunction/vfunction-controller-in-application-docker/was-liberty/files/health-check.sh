#!/usr/bin/env bash
netstat -nlp | grep 9080 | grep tcp | grep -q LISTEN
exit $?
