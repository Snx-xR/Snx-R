# add repo, dt, vt, kt etc.
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b cr-13 .repo/local_manifests #ten-se-permissive
# sync script
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

#cr 13
source build/envsetup.sh
lunch lineage_lavender-userdebug # lunch command 
# lunch nad_lavender-eng # build type/lunch command 

# export some extra module
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
rclone copy out/target/product/$device/*.zip cirrus:$device -P
