#!/usr/bin/env bash

cd /opt/nfsen/src/nfsen-v.$NFSEN_VERSION

echo "" | ./install.pl etc/nfsen-dist.conf

sleep 3

/opt/nfsen/bin/nfsen start

/usr/sbin/php-fpm8.2

/usr/sbin/nginx

sleep infinity
