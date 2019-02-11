#!/bin/sh

sudo sh -c 'echo "nameserver 127.0.0.1" > /etc/resolver/slack.com'
sudo sh -c 'echo "nameserver 127.0.0.1" > /etc/resolver/twitter.com'
dscacheutil -flushcache
