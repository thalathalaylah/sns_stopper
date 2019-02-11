#!/bin/sh

echo 'conf-dir=/usr/local/etc/dnsmasq.d,*.conf' >> /usr/local/etc/dnsmasq.conf
echo "address=/.slack.com/127.0.0.1\naddress=/.twitter.com/127.0.0.1" > /usr/local/etc/dnsmasq.d/sns_stopper.conf

sudo brew services restart dnsmasq
