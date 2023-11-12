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

# 1.修改默认ip
sed -i 's/192.168.1.1/192.168.2.3/g' package/base-files/files/bin/config_generate

# 2.修改主机名
sed -i 's/OpenWrt/Phicomm_N1/g' package/base-files/files/bin/config_generate

# 4.修改版本号
# sed -i "s/OpenWrt /0012h build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 5.修改默认主题
# sed -i ' s/luci-theme-bootstrap/luci-theme-argon/g ' feeds/luci/collections/luci/Makefile
# 或
default_theme='opentomcat'
sed -i "s/bootstrap/$default_theme/g" feeds/luci/modules/luci-base/root/etc/config/luci

# 6.设置ttyd免登录
# sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd

# 7.修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf

# 禁用wifi
# sed -i 's/disabled=0/disabled=1/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# 修改wifi名字
# sed -i 's/ssid=OpenWrt/ssid=N1OpenWrt' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改晶晨宝盒默认配置
# 1.Set the download repository of the OpenWrt files to your github.com
# sed -i "s|https.*/OpenWrt|https://github.com/xuexijiaoben/My-N1-shangyou-dabao|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic
# 2.Set the keywords of Tags in your github.com Releases
# sed -i "s|ARMv8|armvirt|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic
# 3.Set the suffix of the OPENWRT files in your github.com Releases
# sed -i "s|.img.gz|.img.gz|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic
# 4.Set the download path of the kernel in your github.com repository
# sed -i "s|opt/kernel|opt/kernel|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic

# 1.设置OpenWrt 文件的下载仓库
sed -i "s|amlogic_firmware_repo.*|amlogic_firmware_repo 'https://github.com/xuexijiaoben/My-N1-shangyou-dabao'|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic

# 2.设置 Releases 里 Tags 的关键字
sed -i "s|ARMv8|armvirt|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic

# 3.设置 Releases 里 OpenWrt 文件的后缀
# sed -i "s|.img.gz|.OPENWRT_SUFFIX|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic

# 4.设置 OpenWrt 内核的下载路径
sed -i "s|amlogic_kernel_path.*|amlogic_kernel_path 'https://github.com/breakings/OpenWrt'|g" feeds/kenzok8/luci-app-amlogic/root/etc/config/amlogic


# echo '修改时区'
# sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# Add autocore support for armvirt
# sed -i 's/TARGET_rockchip/TARGET_rockchip\|\|TARGET_armvirt/g' package/lean/autocore/Makefile
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# 编译 po2lmo (如果有po2lmo可跳过)
pushd feeds/kenzok8/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
