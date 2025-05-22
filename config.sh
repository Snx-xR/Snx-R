# add repo, dt, vt, kt etc.
repo init -u https://github.com/crDroid-Revived/android.git -b 11.0 --git-lfs
# replace with your manifest
git clone git@github.com:Snax-phycho/manifest.git --depth 1 -b cr .repo/local_manifests
# sync script
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --prune

source build/envsetup.sh
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
# lunch lineage_lavender-userdebug || echo "no problem"
brunch lavender
Snx-R
