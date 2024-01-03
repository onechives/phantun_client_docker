#!/bin/sh

trap "exit 0" SIGTERM
/usr/sbin/phantun.sh
while true
do
  sleep 0.1
done
