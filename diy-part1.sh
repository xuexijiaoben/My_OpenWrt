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
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default
echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic.git' >>feeds.conf.default
echo 'src-git cdnspeedtest https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git' >>feeds.conf.default

# 科学上网插件
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
svn co https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass package/luci-app-bypass

# echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
# sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default

# rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon-18.06
git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/themes/luci-app-argon-config
# echo '### Argon Theme Config ###'

# rm -rf package/luci-app-ikoolproxy
# rm -rf package/luci-app-ikoolproxy2
# git clone --depth 1  https://github.com/ilxp/luci-app-ikoolproxy2.git package/luci-app-ikoolproxy

svn co https://github.com/sbwml/luci-app-alist/trunk/luci-app-alist  package/luci-app-alist



./scripts/feeds update -a
./scripts/feeds install -a
