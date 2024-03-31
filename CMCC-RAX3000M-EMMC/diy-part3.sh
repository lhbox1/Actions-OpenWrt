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
#rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\|openclash\|passwall\|ssr-plus\).*")

rm -rf $(find ./feeds/luci/ -type d -regex ".*\(openclash\|passwall\|ssr-plus\).*")

rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 20.x feeds/packages/lang/golang



# Modify default IP
sed -i 's/192.168.1.1/192.168.15.1/g' package/base-files/files/bin/config_generate
##-----------------Add OpenClash dev core------------------
# curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
# tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
# chmod +x /tmp/clash >/dev/null 2>&1
# mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
# mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
# rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
##-----------------Delete DDNS's examples-----------------
sed -i '/myddns_ipv4/,$d' feeds/packages/net/ddns-scripts/files/etc/config/ddns
##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.3GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo


##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/shuishihan/luci-app-easymesh.git package/feeds/luci/luci-app-easymesh
#argon主题
#git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
