# /bin/bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/OrangeFox
cd ~/OrangeFox
# git clone --depth 1 https://github.com/Sa-Sajjad/kernel_xiaomi_lavender-4.19 kernel/xiaomi/lavender
git clone --depth 1 https://github.com/Sa-Sajjad/device_lavender_recovery -b fbe device/xiaomi/lavender
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang

export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_DEVICE=lavender
export LC_ALL="C"

source build/envsetup.sh
lunch twrp_lavender-eng && mka adbd recoveryimage
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/
