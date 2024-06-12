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

#修改默认IP地址
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.68.1/g" ./package/base-files/files/bin/config_generate

sed -i "s/hostname='.*'/hostname='AX1800'/g" package/base-files/files/bin/config_generate


rm -rf package/kenzo/luci-app-adguardhome
git clone https://github.com/lhbox1/luci-app-adguardhome1 package/luci-app-adguardhome
rm -rf package/kenzo/luci-app-alist
git clone https://github.com/lmq8267/luci-app-alist package/luci-app-alist

rm -rf package/kenzo/luci-app-openclash
git clone --depth=1 --single-branch --branch "dev" https://github.com/vernesong/OpenClash.git package/kenzo/luci-app-openclash

#rm -rf package/kenzo/luci-app-zerotier
git clone https://github.com/zhengmz/luci-app-zerotier package/luci-app-zerotier

rm -rf package/kenzo/luci-app-wechatpush
git clone https://github.com/tty228/luci-app-wechatpush package/luci-app-wechatpush

rm -rf package/kenzo/luci-app-autotimeset
git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset


#预置OpenClash内核和GEO数据
export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version

export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux

export CORE_TYPE=$(echo $OWRT_TARGET | grep -Eiq "64|86" && echo "amd64" || echo "arm64")
export TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

export GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
export GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
export GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

cd ./package/kenzo/luci-app-openclash/luci-app-openclash/root/etc/openclash
curl -sfL -o ./Country.mmdb $GEO_MMDB
curl -sfL -o ./GeoSite.dat $GEO_SITE
curl -sfL -o ./GeoIP.dat $GEO_IP

mkdir ./core && cd ./core

curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
gzip -d ./tun.gz && mv ./tun ./clash_tun

curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
tar -zxf ./dev.tar.gz

chmod +x ./clash* ; rm -rf ./*.gz
