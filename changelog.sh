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
cd out/target/product/$device
ls