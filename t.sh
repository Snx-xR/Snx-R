# Step 1: Install necessary packages and set up the Android build environment
cd ~
sudo apt update
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh

# Step 2: Sync OrangeFox source
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1

# Step 3: Clone necessary device and kernel repositories
cd ~/fox_12.1
git clone --depth 1 https://github.com/Sa-Sajjad/kernel_xiaomi_lavender-udc.git kernel/xiaomi/lavender
git clone --depth 1 https://github.com/Sa-Sajjad/recovery_lavender.git device/xiaomi/lavender

# Step 4: Clone Nexus Clang
git clone --depth 1 -b nexus-14 https://gitlab.com/Project-Nexus/nexus-clang.git clang

# Step 5: Export necessary environment variables
export ALLOW_MISSING_DEPENDENCIES=true
export CLANG_PATH=~/fox_12.1/clang/bin
export PATH=$CLANG_PATH:$PATH
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=~/fox_12.1/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=~/fox_12.1/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export LD_LIBRARY_PATH=~/fox_12.1/clang/lib64:$LD_LIBRARY_PATH

# Verify Clang installation
clang --version

# Step 6: Build OrangeFox Recovery
cd ~/fox_12.1
source build/envsetup.sh
lunch twrp_lavender-eng
mka recoveryimage

# Step 7: Upload the build to SourceForge (adjust paths and credentials as necessary)
device=lavender
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.img sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
rsync -vhcP -e ssh out/target/product/$device/OrangeFox*.zip sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
