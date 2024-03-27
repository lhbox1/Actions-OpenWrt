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


# 预置openclash内核
mkdir -p files/etc/openclash/core


# dev内核
#CLASH_DEV_URL="https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux-arm64.tar.gz"
# premium内核
#CLASH_TUN_URL="https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
#CLASH_META_URL="https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux-arm64.tar.gz"

#wget -qO- $CLASH_DEV_URL | gunzip -c > files/etc/openclash/core/clash
#wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
#wget -qO- $CLASH_META_URL | gunzip -c > files/etc/openclash/core/clash_meta


#master分支内核
# dev内核
CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz"
# premium内核
CLASH_TUN_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"

#DEV分支内核
# dev内核
#CLASH_DEV_URL="https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux-arm64.tar.gz"
# premium内核
#CLASH_TUN_URL="https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
#CLASH_META_URL="https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux-arm64.tar.gz"


#wget -qO- $CLASH_DEV_URL > temp.tar.gz && tar xf temp.tar.gz && mv clash files/etc/openclash/core && rm temp.tar.gz
#wget -qO- $CLASH_TUN_URL > temp.gz && gunzip  temp.gz && mv temp files/etc/openclash/core/clash_tun
#wget -qO- $CLASH_META_URL > temp.tar.gz && tar xzf temp.tar.gz && mv clash files/etc/openclash/core/clash_meta && rm temp.tar.gz

wget -qO- $CLASH_DEV_URL | tar  xOz > files/etc/openclash/core/clash
wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | tar xOz > files/etc/openclash/core/clash_meta

# 给内核权限
chmod +x files/etc/openclash/core/clash*

# meta 要GeoIP.dat 和 GeoSite.dat
#GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
#GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

GEOIP_URL="https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat"
GEOSITE_URL="https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat"
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat

# Country.mmdb
#COUNTRY_LITE_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb
COUNTRY_LITE_URL=https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb
# COUNTRY_FULL_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
wget -qO- $COUNTRY_LITE_URL > files/etc/openclash/Country.mmdb
# wget -qO- $COUNTRY_FULL_URL > files/etc/openclash/Country.mmdb


#chnr_custom_url="https://ispip.clang.cn/all_cn.txt"
#chnr6_custom_url="https://ispip.clang.cn/all_cn_ipv6.txt"
#cndomain_custom_url="https://testingcf.jsdelivr.net/gh/felixonmars/dnsmasq-china-list@master/accelerated-domains.china.conf"
#wget -qO- $chnr_custom_url > files/etc/openclash/china_ip_route.ipset
#wget -qO- $chnr6_custom_url > files/etc/openclash/china_ip6_route.ipset
#wget -qO- $cndomain_custom_url > files/etc/openclash/accelerated-domains.china.conf

#下载使用master版本openclash
#wget  -qO- https://github.com/vernesong/OpenClash/archive/master.zip > temp.zip
#unzip -q temp.zip
#cp -r OpenClash-master/luci-app-openclash package/
#rm -rf OpenClash-master
#rm -rf temp.zip

#下载使用master版本passwall
wget  -qO- https://github.com/xiaorouji/openwrt-passwall/archive/main.zip > temp1.zip
unzip -q temp1.zip
cp -r openwrt-passwall-main/luci-app-passwall package/
rm -rf temp1.zip
rm -rf openwrt-passwall-main



#下载使用passwall依赖kenzok8/small库
#wget  -qO- https://github.com/kenzok8/small/archive/master.zip > temp2.zip
#unzip -q temp2.zip

#cp -r small-master/luci-app-ssr-plus package/
#cp -r small-master/shadow-tls package/

#rm -rf temp2.zip
#rm -rf small-master

#插件库
#wget  -qO- https://github.com/lhbox1/pakg/archive/main.zip > temp3.zip
#unzip -q temp3.zip
#cp -r pakg-main/luci-app-adguardhome package/
#cp -r pakg-main/luci-app-mosdns package/
#cp -r pakg-main/v2dat package/
#rm -rf temp3.zip
#rm -rf pakg-main


#下载使用sbwml版本alist
#wget  -qO- https://github.com/sbwml/luci-app-alist/archive/master.zip > alist.zip
#unzip -q alist.zip
#cp -r luci-app-alist-master/luci-app-alist package/
#rm -rf alist.zip
#rm -rf luci-app-alist-master


#备用
#wget  -qO- https://github.com/xiaorouji/openwrt-passwall2/archive/main.zip > temp2.zip
#wget  -qO- https://github.com/xiaorouji/openwrt-passwall-packages/archive/main.zip > temp3.zip

#cp -r openwrt-passwall2-main/luci-app-passwall2 package/
#cp -r openwrt-passwall-packages-main/dns2socks package/
#cp -r openwrt-passwall-packages-main/dns2tcp package/
#cp -r openwrt-passwall-packages-main/xray-core package/
#cp -r openwrt-passwall-packages-main/chinadns-ng package/
#cp -r openwrt-passwall-packages-main/sing-box package/
#cp -r openwrt-passwall-packages-main/shadowsocks-rust package/
#cp -r openwrt-passwall-packages-main/microsocks package/

#rm -rf openwrt-passwall2-main
#rm -rf openwrt-passwall-packages-main

#rm -rf temp2.zip


#下载使用dev版本openclash
wget  -qO-  wget https://codeload.github.com/vernesong/OpenClash/zip/refs/heads/dev > temp.zip
unzip -q temp.zip
cp -r OpenClash-dev/luci-app-openclash package/
rm -rf OpenClash-dev
rm -rf temp.zip
