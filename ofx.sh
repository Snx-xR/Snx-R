# cd ~
# sudo apt install git aria2 -y
# git clone https://gitlab.com/OrangeFox/misc/scripts
# cd scripts
# sudo bash setup/android_build_env.sh
# sudo bash setup/install_android_sdk.sh
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/OrangeFox
cd ~/OrangeFox
git clone --depth 1 git@github.com:Sa-Sajjad/kernel_xiaomi_lavender-udc.git -b lineage-21 kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/recovery_lavender.git -b ofx device/xiaomi/lavender
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_BUILD_FULL_KERNEL_SOURCES=1
export FOX_ENABLE_APP_MANAGER=1
export FOX_USE_BASH_SHELL=1
export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v26.4.zip
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_ZIP_BINARY=1
export FOX_USE_SED_BINARY=1
export OF_MAINTAINER=Śâjjãd
# export FOX_VERSION="R11.1"
export FOX_BUILD_TYPE=beta
export FOX_ARCH=arm64
export FOX_VARIANT="A14-QPR2"
export TARGET_DEVICE_ALT="lavender"
export FOX_USE_XZ_UTILS=1
export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"
source build/envsetup.sh
lunch twrp_lavender-eng && mka recoveryimage
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/
