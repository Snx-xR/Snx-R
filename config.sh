#*********************************************************************************************************#
send_message() {
    local RESPONSE=$(curl "https://api.telegram.org/bot$BOT_API/sendMessage" -d chat_id="$TELEGRAM_ID" \
        -d "parse_mode=html" \
        -d "disable_web_page_preview=true" \
        -d text="$1")
    local MESSAGE_ID=$(echo "$RESPONSE" | grep -o '"message_id":[0-9]*' | cut -d':' -f2)
    echo "$MESSAGE_ID"
}
#*********************************************************************************************************#
send_file_to_error_chat() {
    curl --progress-bar -F document=@"$1" "https://api.telegram.org/bot$BOT_API/sendDocument" \
        -F chat_id="$TELEGRAM_ID" \
        -F "disable_web_page_preview=true" \
        -F "parse_mode=html" >& /dev/null
}
#*********************************************************************************************************#
upload_to_gofile() {
    SERVER=$(curl -s https://api.gofile.io/servers | jq -r '.data.servers[0].name')
    LINK=$(curl -# -F "file=@$1" "https://${SERVER}.gofile.io/uploadFile" | jq -r '.data|.downloadPage') 2>&1
    echo "$LINK"
    export  GF_LINK="$LINK"
    send_message "$GF_LINK"
}
#*********************************************************************************************************#

send_message "Build started on cirrus"

repo init -u https://github.com/ProjectMatrixx/android.git -b 15.0 --git-lfs
# rm -rf packages/apps/LineageParts vendor/extra
# curl -s $SSH | bash > /dev/null 2>&1; # sudo apt update && sudo apt install ccache -y # > /dev/null 2>&1
rm -rf .repo/local_manifests; git clone git@github.com:Sa-Sajjad/manifest.git -b cr-15 .repo/local_manifests
# /opt/crave/resync.sh;
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

rm -rf hardware/qcom-caf/sdm660/display; git clone https://github.com/Sa-Sajjad/android_hardware_qcom_display -b vic hardware/qcom-caf/sdm660/display
# rm -rf build/soong; git clone https://github.com/zeydann/android_build_soong-axion.git -b lineage-22.2 build/soong

# rm -rf -v hardware/qcom-caf/sdm660/au* hardware/qcom-caf/sdm660/me* hardware/qcom-caf/sdm660/di*
# git clone https://github.com/pix106/android_hardware_qcom-caf_display hardware/qcom-caf/sdm660/display
# git clone https://github.com/pix106/android_hardware_qcom-caf_audio hardware/qcom-caf/sdm660/audio
# git clone https://github.com/pix106/android_hardware_qcom-caf_media hardware/qcom-caf/sdm660/media

source build/envsetup.sh
export TZ=Asia/Dhaka
breakfast lavender
make installclean
brunch lavender

echo -e "uploading on gofile"
# upload_to_gofile out/target/product/*/*.zip # || send_file_to_error_chat out/error.log && exit 1

[ -f out/target/product/*/*.zip ] && upload_to_gofile out/target/product/*/*.zip || { send_file_to_error_chat out/error.log; exit 1; }

echo -e "Enjoy 🎉"