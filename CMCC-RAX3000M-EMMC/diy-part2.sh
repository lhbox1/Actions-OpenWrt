#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.15.1/g' package/base-files/files/bin/config_generate
##-----------------Add OpenClash dev core------------------

curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz -o /tmp/clash1.tar.gz
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz -o /tmp/clash2.tar.gz


mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core


tar zxvf /tmp/clash1.tar.gz -C /tmp >/dev/null 2>&1
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1

tar zxvf /tmp/clash2.tar.gz -C /tmp >/dev/null 2>&1
mv /tmp/clash-linux-arm64-2023.08.17-13-gdcc8d87 /feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_tun >/dev/null 2>&1

tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1

mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1

chmod +x feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash* >/dev/null 2>&1


rm -rf /tmp/*.gz >/dev/null 2>&1


curl -sL -m 30 --retry 2 https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/Country.mmdb
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/geosite.dat
curl -sL -m 30 --retry 2 https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/geoip.dat




##-----------------Delete DDNS's examples-----------------
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo
