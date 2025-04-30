# cd ~
# sudo apt install git aria2 -y
# git clone https://gitlab.com/OrangeFox/misc/scripts
# cd scripts
# sudo bash setup/android_build_env.sh
# sudo bash setup/install_android_sdk.sh
git clone https://gitlab.com/OrangeFox/sync.git; cd sync # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
./orangefox_sync.sh --branch 12.1 --_path /tmp/src/android
cd /tmp/src/android
git clone --depth 1 https://github.com/Sa-Sajjad/device_lavender_recovery device/xiaomi/lavender

export FOX_BUILD_DEVICE=lavender
export LC_ALL="C"

source build/envsetup.sh
lunch twrp_lavender-eng && mka adbd recoveryimage

# export FOX_BUILD_FULL_KERNEL_SOURCES=1
# export FOX_ENABLE_APP_MANAGER=1
# export FOX_USE_BASH_SHELL=1
# export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v26.4.zip
# export FOX_ASH_IS_BASH=1
# export FOX_USE_NANO_EDITOR=1
# export FOX_USE_TAR_BINARY=1
# export FOX_USE_ZIP_BINARY=1
# export FOX_USE_SED_BINARY=1
# export OF_MAINTAINER=Śâjjãd
# # export FOX_VERSION="R11.1"
# export FOX_BUILD_TYPE=beta
# export FOX_ARCH=arm64
# export FOX_VARIANT="A14-QPR2"
# export TARGET_DEVICE_ALT="lavender"
# export FOX_USE_XZ_UTILS=1
# export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"


rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/recovery/