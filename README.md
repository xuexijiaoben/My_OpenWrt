# My-N1

仓库根目录目前有两个 DIY 脚本：diy-part1.sh 和 diy-part2.sh，它们分别在更新与安装 feeds 的前后执行，你可以把对源码修改的指令写到脚本中，比如修改默认 IP、主机名、主题、添加 / 删除软件包等操作

./scripts/diffconfig.sh > seed.config

* NetData：
* If NetData doesn't work correctly,
* Take N1 as an example,
* SSH into container and run command :chown -R root:root /usr/share/netdata/
* then refresh the IP:19999, it should be working properly.


https://github.com/Netflixxp/shangyou

# N1和HK1在线升级方法
* cd /mnt/mmcblk2p4
* wget 升级脚本为`openwrt-update-amlogic` [点这里跳转](https://github.com/Netflixxp/N1HK1dabao/releases)
* wget .gz后缀名的固件链接,鼠标右击后缀.gz文件获取链接地址 [点这里跳转](https://github.com/Netflixxp/N1HK1dabao/releases)
* gzip -d 上一步下载的固件全名
* 上述可以下载下来解压缩手动上传至/mnt/mmcblk2p4
* chmod +x openwrt-update-amlogic
* `./openwrt-update-amlogic` 之后有提示，输入`y`为保留配置升级，选`n`相当于重装。升级完成后系统会自动重启，稍安勿躁。


## [`ophub 的 Openwrt 打包源码`](https://github.com/ophub/flippy-openwrt-actions)


<br />
</details>

---
<details>
<summary>🆘Github Actions 打包脚本使用说明</summary>
<br>

## [`Flippy 的 Openwrt 打包源码`](https://github.com/unifreq/openwrt_packit)

支持一键打包目前已经支持的全部 OpenWrt 固件，如全志（微加云）、瑞芯微（贝壳云，我家云，电犀牛R66S，电犀牛R68S，恒领H88K/H68k，瑞莎5B/E25），以及晶晨 S9xxx 系列型号如 S905x3、S905x2、S922x、S905x、S905d，S905，S912 等。

## 使用方法

在 `.github/workflows` 的编译脚本中引入此 Actions 即可进行打包，例如 [packaging-openwrt.yml](https://github.com/ophub/flippy-openwrt-actions/blob/main/.github/workflows/packaging-openwrt.yml) 中的使用方法，代码如下：

```yaml

- name: Package OpenWrt Firmware
  uses: unifreq/openwrt_packit@master
  env:
    OPENWRT_ARMVIRT: openwrt/bin/targets/*/*/*rootfs.tar.gz
    PACKAGE_SOC: all
    KERNEL_VERSION_NAME: 5.15.95_6.1.15
    GH_TOKEN: ${{ secrets.GH_TOKEN }}

```

打包好的固件在 ${{ env.PACKAGED_OUTPUTPATH }}/* ，可以上传至 github.com 的 Releases 中，代码如下：

```yaml
- name: Upload OpenWrt Firmware to Release
  uses: ncipollo/release-action@main
  with:
    tag: openwrt_armvirt_v8_${{ env.PACKAGED_OUTPUTDATE }}
    artifacts: ${{ env.PACKAGED_OUTPUTPATH }}/*
    allowUpdates: true
    token: ${{ secrets.GH_TOKEN }}
    body: |
      This is OpenWrt firmware for Armvirt 64
      * Firmware information
      Default IP: 192.168.1.1
      Default username: root
      Default password: password
```

## 可选参数说明

可以对 `打包文件`、`make.env`、`选择内核版本`、`选择盒子SoC` 等参数进行个性化配置。

| 参数                   | 默认值                  | 说明                                            |
|------------------------|------------------------|------------------------------------------------|
| OPENWRT_ARMVIRT_PATH   | 无                     | 必选项. 设置 `openwrt-armvirt-64-default-rootfs.tar.gz` 的文件路径，可以使用相对路径如 `openwrt/bin/targets/*/*/*.tar.gz` 或 网络文件下载地址如 `https://github.com/*/releases/*/*.tar.gz` |
| KERNEL_REPO_URL        | breakings/OpenWrt     | 设置内核下载仓库的 `<owner>/<repo>`，默认从 breakings 维护的[内核 Releases](https://github.com/breakings/OpenWrt/releases/tag/kernel_stable)里下载。 |
| KERNEL_VERSION_NAME    | 5.15.95_6.1.15        | 设置[内核版本](https://github.com/breakings/OpenWrt/releases/tag/kernel_stable)，可以查看并选择指定。可指定单个内核如 `6.1.10` ，可选择多个内核用`_`连接如 `6.1.10_5.15.50` |
| KERNEL_AUTO_LATEST     | true                   | 设置是否自动采用同系列最新版本内核。当为 `true` 时，将自动在内核库中查找在 `KERNEL_VERSION_NAME` 中指定的内核如 5.15.95 的同系列是否有更新的版本，如有更新版本时，将自动更换为最新版。设置为 `false` 时将编译指定版本内核。 |
| PACKAGE_SOC            | s905d_s905x3_beikeyun  | 设置打包盒子的 `SOC` ，默认 `all` 打包全部盒子，可指定单个盒子如 `s905x3` ，可选择多个盒子用`_`连接如 `s905x3_s905d` 。各盒子的SoC代码为：`vplus`, `beikeyun`, `l1pro`, `rock5b`, `h88k`, `r66s`, `r68s`, `h68k`, `e25`, `s905`, `s905d`, `s905x2`, `s905x3`, `s912`, `s922x`, `s922x-n2`, `qemu`, `diy`。说明：`s922x-n2` 是 `s922x-odroid-n2`, `diy` 是自定义盒子。 |
| GZIP_IMGS              | auto                   | 设置打包完毕后文件压缩的格式，可选值 `.gz`（默认） / `.xz` / `.zip` / `.zst` / `.7z` |
| SELECT_PACKITPATH      | openwrt_packit         | 设置 `/opt` 下的打包目录名称                     |
| SELECT_OUTPUTPATH      | output                 | 设置 `${SELECT_PACKITPATH}` 目录中固件输出的目录名称 |
| SCRIPT_VPLUS           | mk_h6_vplus.sh         | 设置打包 `h6 vplus` 的脚本文件名                 |
| SCRIPT_BEIKEYUN        | mk_rk3328_beikeyun.sh  | 设置打包 `rk3328 beikeyun` 的脚本文件名          |
| SCRIPT_L1PRO           | mk_rk3328_l1pro.sh     | 设置打包 `rk3328 l1pro` 的脚本文件名             |
| SCRIPT_ROCK5B          | mk_rk3588_rock5b.sh    | 设置打包 `rk3588 rock5b` 的脚本文件名            |
| SCRIPT_H88K            | mk_rk3588_h88k.sh      | 设置打包 `rk3588 h88k` 的脚本文件名              |
| SCRIPT_R66S            | mk_rk3568_r66s.sh      | 设置打包 `rk3568 r66s` 的脚本文件名              |
| SCRIPT_R68S            | mk_rk3568_r68s.sh      | 设置打包 `rk3568 r68s` 的脚本文件名              |
| SCRIPT_H68K            | mk_rk3568_h68k.sh      | 设置打包 `rk3568 h68k` 的脚本文件名              |
| SCRIPT_E25             | mk_rk3568_e25.sh       | 设置打包 `rk3568 e25` 的脚本文件名               |
| SCRIPT_S905            | mk_s905_mxqpro+.sh     | 设置打包 `s905 mxqpro+` 的脚本文件名             |
| SCRIPT_S905D           | mk_s905d_n1.sh         | 设置打包 `s905d n1` 的脚本文件名                 |
| SCRIPT_S905X2          | mk_s905x2_x96max.sh    | 设置打包 `s905x2 x96max` 的脚本文件名            |
| SCRIPT_S905X3          | mk_s905x3_multi.sh     | 设置打包 `s905x3 multi` 的脚本文件名             |
| SCRIPT_S912            | mk_s912_zyxq.sh        | 设置打包 `s912 zyxq` 的脚本文件名                |
| SCRIPT_S922X           | mk_s922x_gtking.sh     | 设置打包 `s922x gtking` 的脚本文件名             |
| SCRIPT_S922X_N2        | mk_s922x_odroid-n2.sh  | 设置打包 `s922x odroid-n2` 的脚本文件名          |
| SCRIPT_QEMU            | mk_qemu-aarch64_img.sh | 设置打包 `qemu` 的脚本文件名                     |
| SCRIPT_DIY             | mk_diy.sh              | 设置打包 `diy` 自定义脚本文件名                  |
| SCRIPT_DIY_PATH        | 无                     | 设置 `SCRIPT_DIY` 文件的来源路径。可以使用网址如 `https://weburl/mydiyfile` 或你仓库中的相对路径如 `script/mk_s905w_tx3.sh` |
| WHOAMI                 | flippy                 | 设置 `make.env` 中 `WHOAMI` 参数的值            |
| OPENWRT_VER            | auto                   | 设置 `make.env` 中 `OPENWRT_VER` 参数的值。默认 `auto` 将自动继承文件中的赋值，设置为其他参数时将替换为自定义参数。 |
| SW_FLOWOFFLOAD         | 1                      | 设置 `make.env` 中 `SW_FLOWOFFLOAD` 参数的值    |
| SFE_FLOW               | 1                      | 设置 `make.env` 中 `SFE_FLOW` 参数的值    |
| HW_FLOWOFFLOAD         | 0                      | 设置 `make.env` 中 `HW_FLOWOFFLOAD` 参数的值    |
| ENABLE_WIFI_K504       | 1                      | 设置 `make.env` 中 `ENABLE_WIFI_K504` 参数的值  |
| ENABLE_WIFI_K510       | 1                      | 设置 `make.env` 中 `ENABLE_WIFI_K510` 参数的值  |
| DISTRIB_REVISION       | R$(date +%Y.%m.%d)     | 设置 `make.env` 中 `DISTRIB_REVISION` 参数的值  |
| DISTRIB_DESCRIPTION    | OpenWrt                | 设置 `make.env` 中 `DISTRIB_DESCRIPTION` 参数的值  |
| GH_TOKEN               | 无                     | 可选项。设置 ${{ secrets.GH_TOKEN }}，用于 [api.github.com](https://docs.github.com/en/rest/overview/resources-in-the-rest-api?apiVersion=2022-11-28#requests-from-personal-accounts) 查询。 |

## 输出参数说明

根据 github.com 的标准输出了 3 个变量，方便编译步骤后续使用。由于 github.com 最近修改了 fork 仓库的设置，默认关闭了 Workflow 的读写权限，所以上传到 `Releases` 需要给账户的个人中心添加 [GITHUB_TOKEN](https://docs.github.com/cn/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) ，并在你 fork 的仓库添加密钥 [GH_TOKEN](https://docs.github.com/cn/authentication/keeping-your-account-and-data-secure/reviewing-your-deploy-keys)， 并启用仓库中的 [Workflow 读写权限](https://user-images.githubusercontent.com/68696949/167585338-841d3b05-8d98-4d73-ba72-475aad4a95a9.png)。

| 参数                            | 默认值                  | 说明                       |
|--------------------------------|-------------------------|---------------------------|
| ${{ env.PACKAGED_OUTPUTPATH }} | /opt/openwrt_packit/output | 打包后的固件所在文件夹的路径  |
| ${{ env.PACKAGED_OUTPUTDATE }} | 08.25.1058              | 打包日期                    |
| ${{ env.PACKAGED_STATUS }}     | success / failure       | 打包状态。成功 / 失败        |

## OpenWrt 固件个性化定制说明

此 `Actions` 仅提供 OpenWrt 打包服务，你需要自己编译 `openwrt-armvirt-64-default-rootfs.tar.gz`。编译方法可以参考 https://github.com/breakings/OpenWrt


<br />
</details>



<br />
</details>


---
<details>
<summary>🆘点击查看编译教程</summary>
<br>

## [`github编译教程`](https://github.com/danshui-git/shuoming#readme)

---
#### [`本地Ubuntu一键编译`](https://github.com/281677160/bendi)
#### [`本地一键提取.config然后在云编译脚本使用`](https://github.com/danshui-git/shuoming/blob/master/yijianconfig.md)

<br />
</details>
