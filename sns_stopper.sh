#!/bin/sh

init () {
  sh dnsmasq/init.sh
}

forbid () {
  sh dnsmasq/forbid.sh
  sh app/forbid.sh
}

permit () {
  sh dnsmasq/permit.sh
  sh app/permit.sh
}

if [ $1 = "forbid" ]; then
  forbid
fi

if [ $1 = "permit" ]; then
  permit
fi
