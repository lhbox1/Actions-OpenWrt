#!/bin/sh
#

opkg install /etc/ipk/*.ipk

sed -i "s/kernel (.*)/kernel (= 5.4.255-1-71d39ab23054c352744e74fe3a674e50)/g" /usr/lib/opkg/status
sleep 1
sed -i "s/install_ipk.sh/wan_check.sh/g" /etc/crontabs/root

rm -rf /etc/ipk
rm -rf /etc/install_ipk.sh
