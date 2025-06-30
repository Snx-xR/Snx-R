# /bin/bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/OrangeFox
cd ~/OrangeFox
# git clone --depth 1 https://github.com/Sa-Sajjad/kernel_xiaomi_lavender-4.19 kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/device_lavender_recovery.git -b 15 device/xiaomi/lavender

export FOX_MISCELLANEOUS_ROOT_DIRECTORY="/data/recovery/"
export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=0
source build/envsetup.sh
lunch twrp_lavender-eng && mka adbd recoveryimage
bash $CIRRUS_WORKING_DIR/gh.sh
