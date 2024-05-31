#!/usr/bin/env bash
netstat -nlp | grep 8090 | grep tcp | grep -q LISTEN
exit $?
