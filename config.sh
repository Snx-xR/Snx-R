# add repo, dt, vt, kt etc.
repo init -u https://github.com/ResurrectionRemix-Revived/manifest.git -b Q --git-lfs
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten-ksu .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh
lunch rr_lavender-userdebug
# export extra module
export TZ=Asia/Dhaka
# export SELINUX_IGNORE_NEVERALLOWS=true
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
m bacon
export GAPPS_BUILD=false
export RELEASE=true
Snx-R