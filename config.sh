repo init -u https://github.com/Lunaris-AOSP/android -b 16 --git-lfs

rm -rf .repo/local_manifests; git clone git@github.com:Sa-Sajjad/manifest.git -b luna .repo/local_manifests

rm -rf prebuilts/clang/host/linux-x86

if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
fi

rm -rf hardware/qcom-caf/sdm660/display external/ant-wireless/ant_native external/ant-wireless/ant_client external/ant-wireless/ant_service
git clone https://github.com/yaap/external_ant-wireless_ant_service -b sixteen external/ant-wireless/ant_service
git clone https://github.com/yaap/external_ant-wireless_ant_client -b sixteen external/ant-wireless/ant_client
git clone https://github.com/LineageOS/android_external_ant-wireless_ant_native -b lineage-22.2 external/ant-wireless/ant_native
git clone https://github.com/Sa-Sajjad/android_hardware_qcom_display -b 15 hardware/qcom-caf/sdm660/display
