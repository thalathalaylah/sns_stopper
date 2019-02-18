#!/bin/sh

SCRIPTPATH=$(dirname $0)

cat ${SCRIPTPATH}/../settings.json | jq -r .apps[] | while read app
do
  open -a $app
done
