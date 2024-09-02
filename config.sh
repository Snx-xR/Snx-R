# add repo, dt, vt, kt etc.
# repo init -u https://github.com/PixelBuildsROM/android_manifest -b unity --depth=1
repo init -u https://github.com/OrionOS-prjkt/android -b 14.0 --git-lfs
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b orion .repo/local_manifests
# sync script
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh && lunch orion_lavender-ap2a-userdebug
export TZ=Asia/Dhaka
# export extra module
# export SELINUX_IGNORE_NEVERALLOWS=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
# vanilla build
mka space
export GAPPS_BUILD=false
export RELEASE=false
Snx-R
