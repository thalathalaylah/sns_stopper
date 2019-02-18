#!/bin/sh

SCRIPTPATH=$(dirname $0)

cat ${SCRIPTPATH}/../settings.json | jq -r .targetDomains[] | while read domain
do
  sudo rm "/etc/resolver/$domain"
done
