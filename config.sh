# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b 10
# replace with your manifest
git clone https://github.com/Amritorock/local_manifest --depth 1 -b 10 .repo/local_manifests #ten-se-permissive
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh
lunch nad_r5x-userdebug
# export extra module
export TZ=Asia/Dhaka
# export SELINUX_IGNORE_NEVERALLOWS=true
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
mka nad
export GAPPS_BUILD=false
export RELEASE=false
Snx-R
# export GAPPS_BUILD=true
# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)
