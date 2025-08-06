repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs
rm -rf .repo/local_manifests; git clone git@github.com:Sa-Sajjad/manifest.git -b luna .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

rm -rf hardware/qcom-caf/sdm660/display; git clone https://github.com/Sa-Sajjad/android_hardware_qcom_display -b 15 hardware/qcom-caf/sdm660/display

source build/envsetup.sh
lunch lineage_lavender-bp2a-user
make installclean
m lunaris