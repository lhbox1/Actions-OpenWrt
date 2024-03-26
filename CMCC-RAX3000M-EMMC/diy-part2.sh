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
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/lhbox1/Actions-OpenWrt/main/CMCC-RAX3000M-EMMC/clash.tar.gz -o /tmp/clash.tar.gz

tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash_meta >/dev/null 2>&1
chmod +x /tmp/clash_tun >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash_meta feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1
mv /tmp/clash_tun feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_tun >/dev/null 2>&1
mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##预置OpenClash内核和GEO数据
curl -sfL -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/Country.mmdb https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
curl -sfL -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoSite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
curl -sfL -o /feeds/luci/applications/luci-app-openclash/root/etc/openclash/GeoIP.dat https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

##-----------------Delete DDNS's examples-----------------
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo

##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome package/luci-app-adguardhome

