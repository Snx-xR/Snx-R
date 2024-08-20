# add repo, dt, vt, kt etc.
# repo init -u https://github.com/PixelBuildsROM/android_manifest -b unity --depth=1
repo init -u https://github.com/AOSPA/manifest -b uvite --depth=1
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b aospa .repo/local_manifests
# sync script
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh && lunch aospa_lavender-eng
export TZ=Asia/Dhaka
# export extra module
# export SELINUX_IGNORE_NEVERALLOWS=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
# vanilla build
./rom-build.sh lavender
export GAPPS_BUILD=false
export RELEASE=false
Snx-R

# crave run --no-patch "source build/envsetup.sh && lunch aospa_lavender-eng
# export TZ=Asia/Dhaka
# ./rom-build.sh lavender"