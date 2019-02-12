#!/bin/sh

SCRIPTPATH=$(dirname $0)

cat ${SCRIPTPATH}/../target_domains | while read domain
do
  sudo rm "/etc/resolver/$domain"
done
