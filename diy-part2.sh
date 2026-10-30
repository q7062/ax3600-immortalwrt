#!/bin/bash
#
# https://github.com
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

# =====================================================================
# 強制讓 Xiaomi AX3600 大分區 (custom-layout) 在編譯時生成 U-Boot 網頁直刷的 factory.bin
# =====================================================================
if [ -f target/linux/qualcommax/image/ipq807x.mk ]; then
    # 1. 在 IMAGES 參數中補上 factory.bin
    sed -i '/define Device\/xiaomi_ax3600-custom-layout/,/endef/s/IMAGES := sysupgrade.bin/IMAGES := factory.bin sysupgrade.bin/g' target/linux/qualcommax/image/ipq807x.mk
    
    # 2. 插入 factory.bin 的打包生成邏輯
    sed -i '/IMAGE\/sysupgrade.bin :=/i \\tIMAGE\/factory.bin := append-kernel | pad-to $$$$(BLOCKSIZE) | append-ubi' target/linux/qualcommax/image/ipq807x.mk
fi
