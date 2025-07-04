#!/bin/bash
#

#删除冲突插件
#rm -rf $(find ./feeds/luci/ -type d -regex ".*\(argon\|design\|openclash\|passwall\|ssr-plus\|smartdns\).*")

rm -rf $(find ./feeds/luci/ -type d -regex ".*\(passwall\|lucky\|easymesh\|openclash\|alist\|smartdns\|adguardhome\|ksmbd\).*")
rm -rf feeds/packages/net/{adguardhome,lucky,alist,mosdns,smartdns}
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
rm -rf package/istore

#修改默认主机名
sed -i "s/hostname='.*'/hostname='RAX3000M_E'/g" package/base-files/files/bin/config_generate

#修改默认IP地址
# sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.15.1/g" ./package/base-files/files/bin/config_generate

#修改immortalwrt.lan关联IP
# sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.15.1/g" $(find feeds/luci/modules/luci-mod-system -type f -name "flash.js")

#修改默认时区
sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

##添加软件包
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome1 package/luci-app-adguardhome
git clone https://github.com/shuishihan/luci-app-easymesh.git package/luci-app-easymesh

#git clone https://github.com/lmq8267/luci-app-alist package/luci-app-alist

#git clone https://github.com/sbwml/luci-app-alist package/luci-app-alist
git clone https://github.com/sbwml/luci-app-openlist package/luci-app-openlist
   

git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall-packages



git clone https://github.com/linkease/istore package/nas-istore
git clone https://github.com/linkease/nas-packages.git package/nas-istore1
git clone https://github.com/linkease/nas-packages-luci.git package/nas-istore2
