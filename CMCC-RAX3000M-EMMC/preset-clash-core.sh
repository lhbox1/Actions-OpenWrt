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
mkdir -p files/etc/AdGuardHome

# AdGuardHome内核
AdGuardHome_URL="https://raw.githubusercontent.com/lhbox1/Actions-OpenWrt/main/CMCC-RAX3000M-EMMC/AdGuardHome.tar.gz"




#master分支内核
# dev内核
CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz"
# premium内核
CLASH_TUN_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"

#自定义
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/lhbox1/Actions-OpenWrt/main/CMCC-RAX3000M-EMMC/clash1.tar.gz -o /tmp/clash.tar.gz
#tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
#mv /tmp/clash_meta files/etc/openclash/core/clash_meta >/dev/null 2>&1
#mv /tmp/clash_tun files/etc/openclash/core/clash_tun >/dev/null 2>&1
#mv /tmp/clash files/etc/openclash/core/clash >/dev/null 2>&1
#rm -rf /tmp/clash.tar.gz >/dev/null 2>&1


#wget -qO- $CLASH_DEV_URL | tar  xOz > files/etc/openclash/core/clash
#wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | tar xOz > files/etc/openclash/core/clash_meta
wget -qO- $AdGuardHome_URL | tar  xOz > files/etc/AdGuardHome/AdGuardHome
# 给内核权限
chmod +x files/etc/openclash/core/clash*
chmod +x files/etc/AdGuardHome/AdGuardHome
# 给wan_check权限
chmod +x files/etc/wan_check.sh
chmod +x files/etc/install_ipk.sh
# meta 要GeoIP.dat 和 GeoSite.dat
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"

wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat

# Country.mmdb
COUNTRY_LITE_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb
wget -qO- $COUNTRY_LITE_URL > files/etc/openclash/Country.mmdb


chnr_custom_url="https://ispip.clang.cn/all_cn.txt"
chnr6_custom_url="https://ispip.clang.cn/all_cn_ipv6.txt"
cndomain_custom_url="https://testingcf.jsdelivr.net/gh/felixonmars/dnsmasq-china-list@master/accelerated-domains.china.conf"
wget -qO- $chnr_custom_url > files/etc/openclash/china_ip_route.ipset
wget -qO- $chnr6_custom_url > files/etc/openclash/china_ip6_route.ipset
wget -qO- $cndomain_custom_url > files/etc/openclash/accelerated-domains.china.conf

#下载使用master版本openclash
wget -qO- https://github.com/vernesong/OpenClash/archive/master.zip > temp.zip
#wget -qO- https://codeload.github.com/vernesong/OpenClash/zip/refs/tags/v0.46.014-beta > temp.zip

unzip -q temp.zip
cp -r OpenClash-master/luci-app-openclash package/

#cp -r OpenClash-0.46.014-beta/luci-app-openclash package/
#rm -rf OpenClash-0.46.014-beta

rm -rf OpenClash-master
rm -rf temp.zip

#下载使用master版本passwall
#wget -qO- https://github.com/xiaorouji/openwrt-passwall/archive/main.zip > temp1.zip
wget -qO- https://codeload.github.com/xiaorouji/openwrt-passwall/zip/refs/tags/4.78-4 > temp1.zip
unzip -q temp1.zip
rm -rf feeds/luci/applications/luci-app-passwall
#cp -r openwrt-passwall-main/luci-app-passwall package/

cp -r openwrt-passwall-4.78-4/luci-app-passwall package/
rm -rf temp1.zip
#rm -rf openwrt-passwall-main
rm -rf openwrt-passwall-4.78-4

#下载使用helloworld依赖库ssr
wget -qO- https://github.com/fw876/helloworld/archive/master.zip > temp2.zip
unzip -q temp2.zip

rm -rf feeds/luci/applications/luci-app-ssr-plus
cp -r helloworld-master/luci-app-ssr-plus package/
cp -r helloworld-master/shadow-tls package/

rm -rf temp2.zip
rm -rf helloworld-master

#下载使用sbwml版本mosdns
#wget  -qO- https://codeload.github.com/sbwml/luci-app-mosdns/zip/refs/tags/v5.3.1 > mosdns.zip
#unzip -q mosdns.zip

#rm -rf feeds/packages/net/mosdns
#rm -rf feeds/packages/net/v2ray-geodata
#git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#cp -r luci-app-mosdns-5.3.1/luci-app-mosdns package/
#cp -r luci-app-mosdns-5.3.1/v2dat package/
#cp -r luci-app-mosdns-5.3.1/mosdns package/
#rm -rf mosdns.zip
#rm -rf luci-app-mosdns-5.3.1


#下载使用dev版本openclash
#wget  -qO-  wget https://codeload.github.com/vernesong/OpenClash/zip/refs/heads/dev > temp.zip
#unzip -q temp.zip
#cp -r OpenClash-dev/luci-app-openclash package/
#rm -rf OpenClash-dev
#rm -rf temp.zip
