#!/usr/bin/env bash
netstat -nlp | grep 8080 | grep tcp | grep -q LISTEN
exit $?
