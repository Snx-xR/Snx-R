cd ~
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1
cd ~/fox_12.1
git clone --depth 1 git@github.com:Sa-Sajjad/kernel_xiaomi_lavender-udc.git kernel/xiaomi/lavender
git clone --depth 1 git@github.com:Sa-Sajjad/recovery_lavender.git device/xiaomi/lavender
git clone --depth 1 -b nexus-14  https://gitlab.com/Project-Nexus/nexus-clang.git clang
export ALLOW_MISSING_DEPENDENCIES=true
clang --version
echo "xddd"
source build/envsetup.sh
lunch twrp_lavender-eng && mka recoveryimage

rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
