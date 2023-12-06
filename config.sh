# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://github.com/ProjectMatrixx/android.git -b 14.0 -g default,-mips,-darwin,-notdefault
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b matrix-14 .repo/local_manifests
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
# Gapps Build
export WITH_GAPPS=true
export EXTRA_GAPPS=false

# some extra module
m bacon
Snx-R