#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
git clone https://github.com/kenzok8/openwrt-packages package/kenzo
git clone https://github.com/kenzok8/small package/small
git clone https://github.com/yuanzhangyin99/5G-Modem-Support package/yuanzhangyin99

#自定义
mkdir -p files/usr/bin
AGH_CORE=https://github.com/sbwml/luci-app-alist/releases/download/v3.28.0/openwrt-22.03-aarch64_cortex-a53.tar.gz
wget -qO- $AGH_CORE | tar xOvz > files/usr/bin/alist
chmod +x files/usr/bin/alist


wget -qO- https://github.com/linkease/istore-packages/archive/main.zip > temp.zip
unzip -q temp.zip
#rm -rf feeds/luci/applications/luci-app-ssr-plus
cp -r istore-packages-main/luci-app-zerotier package/
cp -r istore-packages-main/luci-app-vsftpd package/
rm -rf temp.zip
rm -rf istore-packages-main
