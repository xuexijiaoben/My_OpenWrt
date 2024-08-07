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

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
    	echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}

merge_package main https://github.com/kenzok8/small-package package/app luci-app-adguardhome
# merge_package main https://github.com/kenzok8/small-package package/app adguardhome
merge_package main https://github.com/kenzok8/small-package package/app filebrowser
merge_package main https://github.com/kenzok8/small-package package/app luci-app-filebrowser
# bypass
# merge_package master https://github.com/kiddin9/openwrt-packages package/app luci-app-bypass lua-neturl redsocks2
# v2raya
# merge_package master https://github.com/v2rayA/v2raya-openwrt package/app luci-app-v2raya v2raya
merge_package main https://github.com/mingxiaoyu/luci-app-cloudflarespeedtest package/app applications/luci-app-cloudflarespeedtest
merge_package master https://github.com/immortalwrt-collections/openwrt-cdnspeedtest package/app cdnspeedtest
merge_package v5 https://github.com/sbwml/luci-app-mosdns package/app luci-app-mosdns mosdns v2dat

# 集客AC
# merge_package main https://github.com/xuexijiaoben/My_immortalwrt package/app luci-app-gecoosac
# mkdir -p files/etc/gecoosac
# wget -P files/etc/gecoosac https://raw.githubusercontent.com/xuexijiaoben/My_immortalwrt/main/ac_linux_arm64
## wget -P files/etc/gecoosac https://raw.githubusercontent.com/xuexijiaoben/My_immortalwrt/main/ac_linux_amd64
# chmod -R 755 files
# sed -i 's|/usr/bin/gecoosac|/etc/gecoosac/ac_linux_arm64|g' package/app/luci-app-gecoosac/root/etc/config/gecoosac
## sed -i 's|/usr/bin/gecoosac|/etc/gecoosac/ac_linux_arm64|g' package/app/luci-app-gecoosac/root/etc/init.d/gecoosac
## sed -i 's|/usr/bin/gecoosac|/etc/gecoosac/ac_linux_arm64|g' package/app/luci-app-gecoosac/luasrc/model/cbi/gecoosac.lua
# chmod 755 package/app/luci-app-gecoosac/root/etc/init.d/gecoosac

merge_package main https://github.com/lwb1978/openwrt-gecoosac package/app luci-app-gecoosac
merge_package main https://github.com/lwb1978/openwrt-gecoosac package/app gecoosac

# git clone https://github.com/kenzok8/small-package.git kenzok8
# cp -rf kenzok8/filebrowser package/filebrowser
# cp -rf kenzok8/luci-app-filebrowser package/luci-app-filebrowser
# cp -rf kenzok8/luci-app-adguardhome package/luci-app-adguardhome

# 汇总常用插件
# sed -i '1i src-git haiibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
# sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default

echo 'src-git alist https://github.com/sbwml/luci-app-alist.git' >>feeds.conf.default
echo 'src-git amlogic https://github.com/ophub/luci-app-amlogic.git' >>feeds.conf.default
echo 'src-git lucky https://github.com/sirpdboy/luci-app-lucky.git' >>feeds.conf.default
echo 'src-git ddnsgo https://github.com/sirpdboy/luci-app-ddns-go.git' >>feeds.conf.default
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset.git package/app/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus.git package/app/luci-app-advancedplus
# git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced.git package/app/luci-app-advanced
git clone -b master --depth 1 https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/app/luci-app-unblockneteasemusic
# git clone --depth 1 https://github.com/honwen/luci-app-aliddns package/app/luci-app-aliddns

# Add a feed source
# 添加额外软件包
git clone --depth 1  https://github.com/ilxp/luci-app-ikoolproxy.git package/app/luci-app-ikoolproxy

# 仿istore
echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
echo 'src-git nas https://github.com/linkease/nas-packages.git;master' >> feeds.conf.default
echo 'src-git nas_luci https://github.com/linkease/nas-packages-luci.git;main' >> feeds.conf.default
# svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-quickstart package/istore/luci-app-quickstart
# svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-istorex package/istore/luci-app-istorex
# svn co https://github.com/linkease/nas-packages/trunk/network/services/quickstart package/istore/quickstart

# 科学上网插件
# sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
# svn export https://github.com/haiibo/packages/trunk/luci-app-vssr package/app/luci-app-vssr
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> "feeds.conf.default"
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> "feeds.conf.default"
echo "src-git passwall https://github.com/xiaorouji/openwrt-passwall.git;main" >> "feeds.conf.default"
echo "src-git ssrplus https://github.com/fw876/helloworld.git;master" >>feeds.conf.default
# merge_package master https://github.com/fw876/helloworld package/app/ssrplus lua-neturl redsocks2 shadow-tls v2raya luci-app-ssr-plus

# 开发版openclash
merge_package dev https://github.com/vernesong/OpenClash package/app luci-app-openclash
# echo 'src-git openclash https://github.com/vernesong/OpenClash.git;dev' >>feeds.conf.default
# 下载openclash内核
mkdir -p package/app/luci-app-openclash/root/etc/openclash/core/
wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz | tar xOvz > package/app/luci-app-openclash/root/etc/openclash/core/clash
wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz | gunzip -c > package/app/luci-app-openclash/root/etc/openclash/core/clash_tun
wget -qO- https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz | tar xOvz > package/app/luci-app-openclash/root/etc/openclash/core/clash_meta
wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat > package/app/luci-app-openclash/root/etc/openclash/GeoIP.dat
wget -qO- https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat > package/app/luci-app-openclash/root/etc/openclash/GeoSite.dat
chmod +x package/app/luci-app-openclash/root/etc/openclash/core/clash*

#  已删库
#  git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr package/app/luci-app-vssr
# kenzok8 inclued lua-maxminddb
# git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb package/app/lua-maxminddb

./scripts/feeds update -a

rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/luci/applications/luci-app-mosdns

./scripts/feeds install -a

# 主题
git clone https://github.com/thinktip/luci-theme-neobird.git feeds/luci/themes/luci-theme-neobird
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git feeds/luci/themes/luci-theme-opentomcat
git clone -b main https://github.com/sirpdboy/luci-theme-kucat.git feeds/luci/themes/luci-theme-kucat
git clone https://github.com/derisamedia/luci-theme-alpha.git feeds/luci/themes/luci-theme-alpha

# echo '### Argon Theme Config ###'
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config # if have
git clone -b 18.06 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

# git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon-18.06

./scripts/feeds update -a
./scripts/feeds install -a

# rm -rf feeds/packages/lang/golang
# git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang
