# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Snax-phycho:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b 10
# replace with your manifest
git clone git@github.com:Snax-phycho/manifest.git --depth 1 -b ten-ksu .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
source build/envsetup.sh
export TZ=Asia/Dhaka

lunch nad_lavender-user
make installclean
# export SELINUX_IGNORE_NEVERALLOWS=true
# make api-stubs-docs || echo no problem
# make system-api-stubs-docs || echo no problem
# make test-api-stubs-docs || echo no problem
mka nad
export RELEASE=no
Snx-R
