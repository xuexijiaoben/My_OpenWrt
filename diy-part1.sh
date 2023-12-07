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

# 汇总常用插件
# sed -i '1i src-git haibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default
# echo 'src-git liuran001 https://github.com/liuran001/openwrt-packages' >>feeds.conf.default
# sed -i '$a src-git kenzok8 https://github.com/kenzok8/openwrt-packages' feeds.conf.default

echo 'src-git alist https://github.com/sbwml/luci-app-alist.git' >>feeds.conf.default
echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic.git' >>feeds.conf.default
echo 'src-git lucky https://github.com/sirpdboy/luci-app-lucky.git' >>feeds.conf.default
echo 'src-git ddnsgo https://github.com/sirpdboy/luci-app-ddns-go.git' >>feeds.conf.default
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
git clone --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
git clone --depth 1 https://github.com/honwen/luci-app-aliddns package/luci-app-aliddns
# svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-filebrowser package/luci-app-filebrowser

git clone https://github.com/kenzok8/small-package.git kenzok8
cp -rf kenzok8/filebrowser package/filebrowser
cp -rf kenzok8/luci-app-filebrowser package/luci-app-filebrowser
cp -rf kenzok8/luci-app-adguardhome package/luci-app-adguardhome
rm -rf kenzok8
# svn co https://github.com/kenzok8/small-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
# svn co https://github.com/kenzok8/small-package/trunk/filebrowser package/filebrowser
# svn co https://github.com/kenzok8/small-package/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn co https://github.com/kenzok8/small-package/trunk/adguardhome package/adguardhome


# Add a feed source
# 添加额外软件包
# git clone --depth 1  https://github.com/ilxp/luci-app-ikoolproxy.git package/luci-app-ikoolproxy
echo 'src-git cdnspeedtest https://github.com/immortalwrt-collections/openwrt-cdnspeedtest.git' >>feeds.conf.default
echo 'src-git cloudflarespeedtest https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest.git' >>feeds.conf.default

# 仿istore
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default
# svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-quickstart package/istore/luci-app-quickstart
# svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-istorex package/istore/luci-app-istorex
# svn co https://github.com/linkease/nas-packages/trunk/network/services/quickstart package/istore/quickstart

# 科学上网插件
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
# git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/luci-app-mosdns

echo 'src-git openclash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"
echo "src-git ssrplus https://github.com/fw876/helloworld.git;master" >>feeds.conf.default
# svn co https://github.com/fw876/helloworld/branches/main/luci-app-ssr-plus package/luci-app-ssr-plus
# svn co https://github.com/fw876/helloworld/branches/main/shadow-tls package/shadow-tls

# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
# svn co https://github.com/kiddin9/openwrt-packages/trunk/lua-neturl package/lua-neturl
# svn co https://github.com/kiddin9/openwrt-packages/trunk/redsocks2 package/redsocks2

# v2raya
# svn co https://github.com/v2rayA/v2raya-openwrt/trunk/v2raya package/v2raya
# svn co https://github.com/v2rayA/v2raya-openwrt/trunk/luci-app-v2raya package/luci-app-v2raya

#  已删库
#  git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr
# kenzok8 inclued lua-maxminddb
# git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb


./scripts/feeds update -a
./scripts/feeds install -a

# 主题
git clone https://github.com/thinktip/luci-theme-neobird.git feeds/luci/themes/luci-theme-neobird
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git feeds/luci/themes/luci-theme-opentomcat
git clone https://github.com/derisamedia/luci-theme-alpha.git feeds/luci/themes/luci-theme-alpha

# echo '### Argon Theme Config ###'
rm -rf feeds/luci/themes/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config # if have
git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon-18.06

./scripts/feeds update -a
./scripts/feeds install -a
