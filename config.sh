# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/S-A-build/android_manifest_nusa.git -b stock -g default,-mips,-darwin,-notdefault
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten-ksu .repo/local_manifests #ten-se-permissive
# sync script
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
export BUILD_USERNAME=snaxpsycho
export BUILD_HOSTNAME=snaxpsycho_beta
lunch nad_lavender-userdebug 

# export extra module
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
export RELAX_USES_LIBRARY_CHECK=true
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
mka nad

# gapps build
# export USE_GAPPS=true
# mka nad

# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)
Snx-R
export GAPPS_BUILD=true