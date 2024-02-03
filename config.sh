# add repo, dt, vt, kt etc.
repo init --depth=1 --git-lfs --no-repo-verify https://github.com/ProjectMatrixx/android.git -b 14.0 -g default,-mips,-darwin,-notdefault
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b mtx-14 .repo/local_manifests
# sync script
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
export BUILD_USERNAME=snaxpsycho
export BUILD_HOSTNAME=snaxpsycho_beta
lunch lineage_lavender-userdebug

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
m bacon

# gapps build
# export USE_GAPPS=true
# mka nad

# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)
Snx-R