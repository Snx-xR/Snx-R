cd ~
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh

mkdir ~/twrp
cd ~/twrp
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync
# git clone --depth 1 git@github.com:Sa-Sajjad/kernel_xiaomi_lavender-udc.git kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/recovery_lavender.git device/xiaomi/lavender
rm -rf device/xiaomi/lavender/fox_lavender.mk && touch device/xiaomi/lavender/fox_lavender.mk
rm -rf device/xiaomi/lavender/vendorsetup.sh && touch device/xiaomi/lavender/vendorsetup.sh
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch twrp_lavender-eng && mka recoveryimage
rsync -vhcP -e ssh out/target/product/$device/*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
rsync -vhcP -e ssh out/target/product/$device/*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
