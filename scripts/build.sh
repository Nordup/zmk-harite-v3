#!/usr/bin/env bash
set -euo pipefail
source zephyr/zephyr-env.sh

# Help CMake find Zephyr in this repo layout without needing to patch `zmk/app/CMakeLists.txt`.
# This points `find_package(Zephyr)` at Zephyr's CMake package config:
#   ${ZEPHYR_BASE}/share/zephyr-package/cmake/ZephyrConfig.cmake
if [ -z "${Zephyr_DIR:-}" ]; then
  export Zephyr_DIR="${ZEPHYR_BASE}/share/zephyr-package/cmake"
fi

if [ -z "${1:-}" ]; then
  echo "Error: build.sh <side(left/right)>"
fi

SIDE=${1}
west build -p auto -s zmk/app -S zmk-usb-logging -b seeeduino_xiao_ble -S studio-rpc-usb-uart -- -DSHIELD=harite_v3_${SIDE} -DZMK_CONFIG=$PWD/config -DCONFIG_ZMK_STUDIO=y
