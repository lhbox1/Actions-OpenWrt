#!/bin/bash
#=================================================
# File name: DIY.sh
#下载使用lucky
wget  -qO- https://codeload.github.com/gdy666/luci-app-lucky/zip/refs/tags/v2.15.8 > lucky.zip
unzip -q lucky.zip
cp -r luci-app-lucky-2.15.8/luci-app-lucky package/
cp -r luci-app-lucky-2.15.8/lucky package/
rm -rf lucky.zip
rm -rf luci-app-lucky-2.15.8