# add repo, dt, vt, kt etc.
repo init -u https://github.com/Evolution-X/manifest -b udc
# replace with your manifest
git clone git@github.com:Sa-Sajjad/manifest.git --depth 1 -b evo-14 .repo/local_manifests #ten-se-permissive
# sync script
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

source build/envsetup.sh
# lunch lineage_lavender-userdebug # lunch command 
# lunch nad_lavender-eng # build type/lunch command 

# export extra module
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
export BUILD_BROKEN_GENRULE_SANDBOXING=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export BUILD_BROKEN_CLANG_PROPERTY=true
lunch evolution_lavender-userdebug
make api-stubs-docs || echo no problem
make system-api-stubs-docs || echo no problem
make test-api-stubs-docs || echo no problem
# vanilla build
mka evolution

# gapps build
# export USE_GAPPS=true
# mka nad

# # only specific app build
# export BOARD_USES_SYSTEMUI=true
# mka SystemUI
# bash <(curl -s $script/upload_apps.sh)
Snx-R