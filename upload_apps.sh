#*********************************************************************************************************#
function file_push() {
    curl -F document=@$1 "https://api.telegram.org/bot$bot_api/sendDocument" \
         -F chat_id="$tg_id" \
         -F "disable_web_page_preview=true" \
         -F "parse_mode=html" \
         -F caption="$2"
}
#*********************************************************************************************************#
cd ~/$rom_name
cd out
ls
cd target
ls
cd product
ls
cd $device
ls 
cd system_etc
ls
cd priv-app
ls
cd SystemUI
zip SystemUI.zip SystemUI.apk 
file_push "SystemUI.zip" "System Ui"
cd ..
cd Settings
zip Settings.zip Settings.apk
file_push "Settings.zip" "Settings"
# cd ..
# cd ..
# cd ..
# cd framework
# zip snx.zip framework-res.apk
# bash <(curl -s $script/tg_uploader.sh)
# bash <(curl -s $script/dev_uploader.sh) -f framework.jar