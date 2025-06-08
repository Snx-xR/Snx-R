# /bin/bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/OrangeFox
cd ~/OrangeFox
# git clone --depth 1 https://github.com/Sa-Sajjad/kernel_xiaomi_lavender-4.19 kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/device_lavender_recovery.git -b 15 device/xiaomi/lavender

# export ALLOW_MISSING_DEPENDENCIES=true
# export FOX_BUILD_DEVICE=lavender
# export LC_ALL="C"

source build/envsetup.sh
source $CIRRUS_WORKING_DIR/env.sh
export OF_ENABLE_ALL_PARTITION_TOOLS=1
lunch twrp_lavender-eng && mka adbd recoveryimage
bash $CIRRUS_WORKING_DIR/gh.sh
