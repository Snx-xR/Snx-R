# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Snax-phycho:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b weather
# replace with your manifest
git clone git@github.com:Snax-phycho/manifest.git --depth 1 -b ten-ksu .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh
export TZ=Asia/Dhaka
export USE_GAPPS=true
export WITH_GAPPS=true
export EXTRA_GAPPS=false
lunch nad_lavender-user
# export extra module
export SELINUX_IGNORE_NEVERALLOWS=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
mka nad
# cd packages/apps/Launcher3 && mma
# make SystemUI -j$(nproc)
# mmm packages/apps/Launcher3 -j$(nproc)
# m framework
# m Settings
export RELEASE=no
Snx-R
