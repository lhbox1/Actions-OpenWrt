#!/bin/bash
#=================================================
# File name: preset-clash-core.sh
# Usage: <preset-clash-core.sh $platform> | example: <preset-clash-core.sh armv8>
# System Required: Linux
# Version: 1.0
# Lisence: MIT
# Author: SuLingGG
# Blog: https://mlapp.cn
#=================================================


# 预置openclash和AdGuardHome内核
mkdir -p files/etc/openclash/core

#master分支内核
# Meta内核版本
CLASH_META_URL="https://github.com/lhbox1/lhatv/raw/main/clash_meta.tar.gz"
wget -qO- $CLASH_META_URL | tar xOz > files/etc/openclash/core/clash_meta
# 给内核权限
chmod +x files/etc/openclash/core/clash*
# 给wan_check权限
chmod +x files/etc/wan_check.sh
chmod +x files/etc/install_ipk.sh
chmod +x files/etc/hostsUpdate.sh
# GeoSite.dat
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat

# Country.mmdb
COUNTRY_LITE_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb
wget -qO- $COUNTRY_LITE_URL > files/etc/openclash/Country.mmdb
chnr_custom_url="https://ispip.clang.cn/all_cn.txt"
chnr6_custom_url="https://ispip.clang.cn/all_cn_ipv6.txt"
#cndomain_custom_url="https://testingcf.jsdelivr.net/gh/felixonmars/dnsmasq-china-list@master/accelerated-domains.china.conf"
wget -qO- $chnr_custom_url > files/etc/openclash/china_ip_route.ipset
wget -qO- $chnr6_custom_url > files/etc/openclash/china_ip6_route.ipset
#wget -qO- $cndomain_custom_url > files/etc/openclash/accelerated-domains.china.conf

#下载使用master版本openclash
wget -qO- https://github.com/vernesong/OpenClash/archive/master.zip > temp.zip
unzip -q temp.zip
cp -r OpenClash-master/luci-app-openclash package/
rm -rf OpenClash-master
rm -rf temp.zip

#下载使用master版本passwall
wget -qO- https://github.com/xiaorouji/openwrt-passwall/archive/main.zip > temp1.zip
#wget -qO- https://codeload.github.com/xiaorouji/openwrt-passwall/zip/refs/tags/25.5.16-1 > temp1.zip

unzip -q temp1.zip

cp -r openwrt-passwall-main/luci-app-passwall package/
#cp -r openwrt-passwall-25.5.16-1/luci-app-passwall package/

rm -rf temp1.zip

rm -rf openwrt-passwall-main
#rm -rf openwrt-passwall-25.5.16-1


#下载使用lucky
wget  -qO- https://codeload.github.com/gdy666/luci-app-lucky/zip/refs/tags/v2.15.7 > lucky.zip
unzip -q lucky.zip
cp -r luci-app-lucky-2.15.7/luci-app-lucky package/
cp -r luci-app-lucky-2.15.7/lucky package/
rm -rf lucky.zip
rm -rf luci-app-lucky-2.15.7


#下载使用mosdns
git clone --depth=1 --single-branch --branch "master" https://github.com/kenzok8/small.git ./small
git clone --depth=1 --single-branch --branch "master" https://github.com/kenzok8/openwrt-packages.git ./small-openwrt-packages

cp -r small/luci-app-mosdns package/
cp -r small/v2dat package/
cp -r small/mosdns package/

cp -r small-openwrt-packages/luci-app-smartdns package/
cp -r small-openwrt-packages/smartdns package/

rm -rf small-openwrt-packages
rm -rf small

