# add repo, dt, vt, kt etc.
repo init --depth=1 --no-repo-verify -u https://Sa-Sajjad:$ght@github.com/Nusantara-SiXtY-N9/android_manifest_nusa.git -b 10
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b ten-ksu .repo/local_manifests
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
# vanilla build
# mka nad
mmm device/xiaomi/lavender/XiaomiParts
# m framework
# m Settings
export RELEASE=true
rsync -vhcP -e ssh out/target/product/lavender/system/priv-app/XiaomiParts/XiaomiParts.apk sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/app/
Snx-R