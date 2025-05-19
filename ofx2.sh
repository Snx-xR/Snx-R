# /bin/bash
cd ~/OrangeFox
# git clone --depth 1 https://github.com/Sa-Sajjad/kernel_xiaomi_lavender-4.19 kernel/xiaomi/lavender
rm -rf device/xiaomi/lavender
git clone --depth 1 https://github.com/Sa-Sajjad/device_lavender_recovery -b fbe device/xiaomi/lavender
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang

export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=lavender
export LC_ALL="C"

source build/envsetup.sh
lunch twrp_lavender-eng
make clean
mka adbd recoveryimage
bash $CIRRUS_WORKING_DIR/gh.sh