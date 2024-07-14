# add repo, dt, vt, kt etc.
repo init -u https://github.com/PixelBuildsROM/android_manifest -b unity --depth=1
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten-ksu .repo/local_manifests
# sync script
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
source build/envsetup.sh
export TZ=Asia/Dhaka
lunch nad_lavender-user
# export extra module
# export SELINUX_IGNORE_NEVERALLOWS=true
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
mka nad
export GAPPS_BUILD=false
export RELEASE=false
Snx-R