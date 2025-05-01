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

#删除冲突插件
#rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\|openclash\|passwall\|ssr-plus\|smartdns\).*")

rm -rf $(find ./feeds/luci/ -type d -regex ".*\(passwall\|lucky\|openclash\|alist\).*")
rm -rf feeds/packages/net/{alist,mosdns,smartdns}
rm -rf feeds/packages/utils/v2dat

#passwall
rm -rf feeds/packages/net/sing-box
rm -rf feeds/packages/net/trojan-plus
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/hysteria
rm -rf feeds/packages/net/dns2socks
rm -rf feeds/packages/net/geoview
rm -rf feeds/packages/net/ipt2socks
rm -rf feeds/packages/net/microsocks
rm -rf feeds/packages/net/naiveproxy
rm -rf feeds/packages/net/shadowsocks-libev
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/shadowsocksr-libev
rm -rf feeds/packages/net/simple-obfs
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/tuic-client
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-plugin
rm -rf feeds/packages/net/xray-plugin



##
rm -rf feeds/packages/net/adguardhome
rm -rf package/istore
rm -rf feeds/packages/net/lucky

rm -rf feeds/packages/net/alist
#rm -rf feeds/packages/net/oaf

#修改默认主机名
sed -i "s/hostname='.*'/hostname='RAX3000M_E'/g" package/base-files/files/bin/config_generate

#修改默认IP地址
# sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.15.1/g" ./package/base-files/files/bin/config_generate

#修改immortalwrt.lan关联IP
# sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.15.1/g" $(find feeds/luci/modules/luci-mod-system -type f -name "flash.js")
##-----------------Add OpenClash dev core------------------
# curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
# tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
# chmod +x /tmp/clash >/dev/null 2>&1
# mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
# mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
# rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
##-----------------Delete DDNS's examples-----------------
#sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7981B-----------------
#sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo

#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

##添加软件包
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome1 package/luci-app-adguardhome
git clone https://github.com/shuishihan/luci-app-easymesh.git package/luci-app-easymesh

git clone https://github.com/lmq8267/luci-app-alist package/luci-app-alist

#git clone https://github.com/sbwml/luci-app-alist package/luci-app-alist

   

git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall-packages



git clone https://github.com/linkease/istore package/nas-istore
git clone https://github.com/linkease/nas-packages.git package/nas-istore1
git clone https://github.com/linkease/nas-packages-luci.git package/nas-istore2
