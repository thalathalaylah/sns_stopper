#!/bin/sh

SCRIPTPATH=$(dirname $0)

cat ${SCRIPTPATH}/target_domains | while read domain
do
  sudo sh -c "echo \"nameserver 127.0.0.1\" > /etc/resolver/$domain"
done

dscacheutil -flushcache
