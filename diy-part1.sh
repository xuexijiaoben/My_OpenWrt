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

# 汇总常用插件
# sed -i '1i src-git haibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git kenzok8 https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default
# echo 'src-git liuran001 https://github.com/liuran001/openwrt-packages' >>feeds.conf.default

# Add a feed source
echo 'src-git cdnspeedtest https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git' >>feeds.conf.default
echo 'src-git cloudflarespeedtest https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git' >>feeds.conf.default

# 仿istore
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-quickstart package/istore/luci-app-quickstart
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-istorex package/istore/luci-app-istorex
svn co https://github.com/linkease/nas-packages/trunk/network/services/quickstart package/istore/quickstart

# 科学上网插件
# git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/luci-app-mosdns
echo 'src-git ssrplus https://github.com/fw876/helloworld' >>feeds.conf.default

echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"

# svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
# svn co https://github.com/kenzok8/small-package/trunk/luci-app-passwall package/luci-app-passwall
svn co https://github.com/kenzok8/small-package/trunk/luci-app-bypass package/luci-app-bypass
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr

# kenzok8 inclued lua-maxminddb
# git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb

# echo 'src-git lucky https://github.com/sirpdboy/luci-app-lucky' >>feeds.conf.default
# echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default

# 添加额外软件包
# echo 'src-git alist https://github.com/sbwml/luci-app-alist' >>feeds.conf.default
# echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic.git' >>feeds.conf.default
# svn co https://github.com/kenzok8/openwrt-packages/trunk/adguardhome package/adguardhome
# svn co https://github.com/kenzok8/openwrt-packages/trunk/filebrowser package/filebrowser
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-filebrowser package/luci-app-filebrowser
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-store package/luci-app-store
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-lib-taskd package/luci-lib-taskd
# svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-lib-xterm package/luci-lib-xterm
# svn co https://github.com/kenzok8/openwrt-packages/trunk/smartdns package/smartdns
# svn co https://github.com/kenzok8/openwrt-packages/trunk/taskd package/taskd
# svn co https://github.com/kenzok8/openwrt-packages/trunk/v2ray-geodata package/v2ray-geodata
# svn co https://github.com/kenzok8/openwrt-packages/trunk/UnblockNeteaseMusic package/UnblockNeteaseMusic
# git clone --depth 1  https://github.com/ilxp/luci-app-ikoolproxy.git package/luci-app-ikoolproxy

# 主题
# https://github.com/gngpp/luci-theme-design
# echo 'src-git neobird https://github.com/thinktip/luci-theme-neobird' >>feeds.conf.default
git clone https://github.com/thinktip/luci-theme-neobird feeds/luci/themes/luci-theme-neobird
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon-18.06
# git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/themes/luci-app-argon-config
# echo '### Argon Theme Config ###'

./scripts/feeds update -a
./scripts/feeds install -a
