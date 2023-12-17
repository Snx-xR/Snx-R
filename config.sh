# add repo, dt, vt, kt etc.
repo init --depth=1 --git-lfs --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 11.0 -g default,-mips,-darwin,-notdefault
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b cr-11 .repo/local_manifests #ten-se-permissive
# sync script
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
lunch lineage_lavender-userdebug
# export extra module
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
export RELAX_USES_LIBRARY_CHECK=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
m bacon
# brunch lineage_lavender-userdebug
# gapps build
# export USE_GAPPS=true
# mka nad

# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)
Snx-R
export GAPPS_BUILD=f