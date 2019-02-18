#!/bin/sh

SCRIPTPATH=$(dirname $0)
if [ ! -d /etc/resolver ]; then
  sudo mkdir /etc/resolver
fi

cat ${SCRIPTPATH}/../settings.json | jq -r .targetDomains[] | while read domain
do
  sudo sh -c "echo \"nameserver 127.0.0.1\" > /etc/resolver/$domain"
done

dscacheutil -flushcache
