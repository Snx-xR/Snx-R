# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b stock
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten-ksu .repo/local_manifests #ten-se-permissive
# sync script
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
lunch nad_lavender-userdebug # lunch command 
# lunch nad_lavender-eng # build type/lunch command 

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

export GAPPS_BUILD=false
Snx-R