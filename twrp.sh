sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh
mkdir ~/twrp
cd ~/twrp
repo init  --depth=1 --no-repo-verify -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
# git clone --depth 1 git@github.com:Sa-Sajjad/kernel_xiaomi_lavender-udc.git kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/recovery_lavender.git -b twrp device/xiaomi/lavender
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang
export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch twrp_lavender-eng && mka recoveryimage
cd out/target/product/$device
ls
rsync -vhcP -e ssh re*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
