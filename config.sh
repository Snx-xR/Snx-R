///# add repo, dt, vt, kt etc.
# repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/S-A-build/android_manifest_nusa.git -b 10
repo init -u https://github.com/SuperiorExtended/manifest -b UDC --git-lfs
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b sup-ex-common .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh

lunch superior_lavender-eng
# export extra module
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export SKIP_ABI_CHECKS=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES=true
export RELAX_USES_LIBRARY_CHECK=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
# vanilla build
mka bacon
export GAPPS_BUILD=no
export RELEASE=false
Snx-R
# export GAPPS_BUILD=true
# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)