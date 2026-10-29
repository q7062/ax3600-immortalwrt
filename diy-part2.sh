#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修改 AX3600 DTS 分區為大分區佈局 (相容 uBootKit / 240M 大分區)
sed -i 's/<0x0 0x23c0000>/<0x0 0xef00000>/g' target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq807x-xiaomi-ax3600.dtsi || true
find target/linux/qualcommax/ -name "*ax3600*.dts*" -exec sed -i 's/36044800/251658240/g' {} + || true
