#!/bin/sh

SCRIPTPATH=$(dirname $0)

cat ${SCRIPTPATH}/apps | while read app
do
  killall $app
done
