#!/bin/sh
#

opkg install /etc/ipk/*.ipk --force-downgrade

sleep 1
sed -i "s/install_ipk.sh/wan_check.sh/g" /etc/crontabs/root

rm -rf /etc/ipk
rm -rf /etc/install_ipk.sh
