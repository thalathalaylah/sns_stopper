#!/bin/sh

SCRIPTPATH=$(dirname $0)


if ! grep 'conf-dir=/usr/local/etc/dnsmasq.d,\*.conf' /usr/local/etc/dnsmasq.conf > /dev/null 2>&1; then
  echo 'conf-dir=/usr/local/etc/dnsmasq.d,*.conf' >> /usr/local/etc/dnsmasq.conf
fi

result=""

data=`cat ${SCRIPTPATH}/target_domains`
while read line
do
  partial_result="address=/.$line/127.0.0.1\n"
  result="$result$partial_result"
done << FILE
$data
FILE

echo "$result" > /usr/local/etc/dnsmasq.d/sns_stopper.conf
sudo brew services restart dnsmasq
