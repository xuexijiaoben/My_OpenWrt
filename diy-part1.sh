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
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
sed -i '$a src-git kenzok8 https://github.com/kenzok8/openwrt-packages' feeds.conf.default
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default
# echo 'src-git liuran001 https://github.com/liuran001/openwrt-packages' >>feeds.conf.default

# Add a feed source
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
# git clone --depth 1 https://github.com/sbwml/luci-app-mosdns.git package/luci-app-mosdns

echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"

echo "src-git ssrplus https://github.com/fw876/helloworld.git;master" >>feeds.conf.default
# svn co https://github.com/fw876/helloworld/branches/main/luci-app-ssr-plus package/luci-app-ssr-plus
# svn co https://github.com/fw876/helloworld/branches/main/shadow-tls package/shadow-tls

# svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-bypass package/luci-app-bypass
# svn co https://github.com/kiddin9/openwrt-packages/trunk/lua-neturl package/lua-neturl
# svn co https://github.com/kiddin9/openwrt-packages/trunk/redsocks2 package/redsocks2

#  已删库
#  git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr

# v2raya
# svn co https://github.com/v2rayA/v2raya-openwrt/trunk/v2raya package/v2raya
# svn co https://github.com/v2rayA/v2raya-openwrt/trunk/luci-app-v2raya package/luci-app-v2raya

# svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
# svn co https://github.com/kenzok8/small-package/trunk/luci-app-passwall package/luci-app-passwall
# kenzok8 inclued lua-maxminddb
# git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
# echo 'src-git lucky https://github.com/sirpdboy/luci-app-lucky' >>feeds.conf.default
# echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >>feeds.conf.default

# 添加额外软件包
# echo 'src-git alist https://github.com/sbwml/luci-app-alist' >>feeds.conf.default
# echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic.git' >>feeds.conf.default
# git clone --depth 1  https://github.com/ilxp/luci-app-ikoolproxy.git package/luci-app-ikoolproxy

# 主题
git clone https://github.com/thinktip/luci-theme-neobird.git feeds/luci/themes/luci-theme-neobird
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git feeds/luci/themes/luci-theme-opentomcat

# https://github.com/gngpp/luci-theme-design
# echo 'src-git neobird https://github.com/thinktip/luci-theme-neobird' >>feeds.conf.default
# rm -rf feeds/luci/themes/luci-theme-argon
# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon-18.06
# git clone https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/themes/luci-app-argon-config
# echo '### Argon Theme Config ###'

./scripts/feeds update -a
./scripts/feeds install -a
