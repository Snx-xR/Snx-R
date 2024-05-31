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
# git clone --depth 1 git@github.com:Sa-Sajjad/kernel_xiaomi_lavender-udc.git kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/recovery_lavender.git -b 14.0 device/xiaomi/lavender
# git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_DYNAMIC_PARTITIONS=0
source build/envsetup.sh
lunch twrp_lavender-eng && mka recoveryimage
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
