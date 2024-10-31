# add repo, dt, vt, kt etc.
# repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b 10
repo init --depth=1 --no-repo-verify -u https://Snax-phycho:$ght@github.com/keepQASSA/manifest -b Q
# replace with your manifest
git clone git@github.com:Snax-phycho/manifest.git --depth 1 -b qassa .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune

source build/envsetup.sh
export TZ=Asia/Dhaka
# export USE_GAPPS=true
# export WITH_GAPPS=true
# export EXTRA_GAPPS=false
lunch qassa_lavender-user
# export extra module
# export SELINUX_IGNORE_NEVERALLOWS=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
# vanilla build
mka qassa -j$(nproc --all)
export GAPPS_BUILD=false
export RELEASE=no
Snx-R