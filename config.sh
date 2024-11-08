# add repo, dt, vt, kt etc.
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
# replace with your manifest
git clone git@github.com:Snax-phycho/manifest.git --depth 1 -b cr-14 .repo/local_manifests
# sync script
repo sync -j$(nproc --all) --no-clone-bundle --no-tags --optimized-fetch --prune
# /opt/crave/resync.sh
# lunch combo paste here
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
breakfast lavender
# export TZ=Asia/Dhaka
# make installclean
# brunch lavender
mka bootimage
Snx-R