#*********************************************************************************************************#
function bot_msg() {
    curl -s -X POST "https://api.telegram.org/bot$bot_api/sendMessage" \
        -d chat_id="$tg_id" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="$1"
}
#*********************************************************************************************************#
cd ~/$rom_name

function changelog() {
    txt=out/target/product/$device/*Changelog.txt
    txt2=out/target/product/$device/*Changelog*.txt
    txt3=out/target/product/$device/*-Changelog-*.txt
    txt4=out/target/product/$device/*-changelog.txt
    
    if [ -n "$(ls -A $txt)" ]; then
         echo "found $txt "
         bot_msg "Changelog: %0A <code> $(cat $txt) </code>"
         rm $txt
    fi
    
    if [ -n "$(ls -A $txt2)" ]; then
         echo "found $txt2 "
         bot_msg "Changelog: %0A <code> $(cat $txt2) </code>"
         rm $txt2
    fi
    
    if [ -n "$(ls -A $txt3)" ]; then
         echo "found $txt3 "
         bot_msg "Changelog: %0A <code> $(cat $txt3) </code>"
         rm $txt3
    fi
    
    if [ -n "$(ls -A $txt4)" ]; then
         echo "found $txt4 "
         bot_msg "Changelog: %0A <code> $(cat $txt4) </code>"
         rm $txt4
    fi
    
}

changelog
cd out/target/product/$device/
ls