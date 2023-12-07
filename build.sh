#!/bin/bash
logo_url=https://raw.githubusercontent.com/Snx-xR/Snx-R/main/snx.png

# message="◦•●◉✿ 🅑🅤🅘🅛🅓 🅢🅤🅒🅒🅔🅔🅓 ✿◉●•◦%0A%0A➜<b>Name:</b> <code>$dlink</code>%0A%0A➜<b>Size:</b> <code>$(du -sh $file | cut -d o -f 1 | cut -d / -f 4 | cut -d - -f 1)</code>%0A%0A➜<b>Download Link:</b> <a href='$link'>Click Here</a>%0A%0A➜<b>Time Took:</b> <code>$(($DIFF / 60))Min $(($DIFF % 60))Sec</code>%0A%0A➜<b>Total Disk used:</b> <code>$(du -sh)</code>%0A%0A➜<b>Build Date:</b> <code>$(date)</code>%0A%0A<b>◦•●◉✿ by Sã Śâjjãd ✿◉●•◦</b>"

cd ~/$rom_name

#*********************************************************************************************************#
function bot_msg() {
    curl -s -X POST "https://api.telegram.org/bot$bot_api/sendMessage" \
        -d chat_id="$tg_id" \
        -d "disable_web_page_preview=true" \
        -d "parse_mode=html" \
        -d text="$1"
}
#*********************************************************************************************************#
function file_push() {
    curl -F document=@$1 "https://api.telegram.org/bot$bot_api/sendDocument" \
         -F chat_id="$tg_id" \
         -F "disable_web_page_preview=true" \
         -F "parse_mode=html" \
         -F caption="$2"
}
#*********************************************************************************************************#
function photo_push() {
    curl -F "chat_id=$tg_id" \
         -F "photo=$logo_url" \
         -F "caption=$1" \
         -F "parse_mode=HTML" \
         "https://api.telegram.org/bot$bot_api/sendPhoto"
}
#*********************************************************************************************************#
function remove_ota() {
    ota3=out/target/product/$device/*-ota-*.zip
    ota2=out/target/product/$device/*-*-OTA-*.zip
    ota=out/target/product/$device/*ota*.zip
    if [ -n "$(ls -A $ota3)" ]; then
         echo "found $ota3 Removing file"
         rm $ota3
    fi
    if [ -n "$(ls -A $ota2)" ]; then
         echo "found $ota2 Removing file"
         rm $ota2
    fi
    if [ -n "$(ls -A $ota)" ]; then
         echo "found $ota Removing file"
         rm $ota
    fi
}
#*********************************************************************************************************#
function vanilla_build() {
    START=$(date +"%s")
    DIFF=$(($END - $START))
    file=out/target/product/$device/*.zip
    dlink=$(basename $file)
    link="https://sourceforge.net/projects/snx-r/files/$device/$dlink/download"
    # Telegram Notifier
    bot_msg "Repo sync complete. Vanilla Build Started"
    # export CCACHE_DIR=~/ccache/$rom_name/$device
    # export CCACHE_EXEC=$(which ccache)
    # export USE_CCACHE=1
    # ccache -M 25G
    # ccache -z
    # command=$(tail $CIRRUS_WORKING_DIR/config.sh -n +$(expr $(grep 'build/envsetup.sh' $CIRRUS_WORKING_DIR/config.sh -n | cut -f1 -d:) - 1) | head -n -1 | grep -v 'Snx-R')
    # bash -c "$command"
    # Remove OTA zip
    remove_ota
	END=$(date +"%s")
    # Verify Files
	if ! [ -n "$(ls -A $file)" ]; then
           echo "Error: $file not found"
       if [ -n "$(ls -A out/error.log)" ]; then
           bot_msg "<b>Build Throws Errors </b> %0A <code>$(cat out/error.log)</code>"
       else
           bot_msg "<b>Build Throws Errors. </b> Log not found "
       fi
	       exit 1
	   else
	       bot_msg "Rom Compilation Finished. Started Uploading"
	       # Uploading to Sourceforge.net
	       rsync -vhcP -e ssh $file sa-sajjad@frs.sourceforge.net:/home/frs/project/snx-r/$device/
	       # Compile Complete message sent to tg bot
	       bot_msg "◦•●◉✿ 🅑🅤🅘🅛🅓 🅢🅤🅒🅒🅔🅔🅓 ✿◉●•◦%0A%0A➜<b>Name:</b> <code>$dlink</code>%0A%0A➜<b>Size:</b> <code>$(du -sh $file | cut -d o -f 1 | cut -d / -f 4 | cut -d - -f 1)</code>%0A%0A➜<b>Download Link:</b> <a href='$link'>Click Here</a>%0A%0A➜<b>Time Took:</b> <code>$(($DIFF / 60))Min $(($DIFF % 60))Sec</code>%0A%0A➜<b>Total Disk used:</b> <code>$(du -sh)</code>%0A%0A➜<b>Build Date:</b> <code>$(date)</code>%0A%0A<b>◦•●◉✿ by Sã Śâjjãd ✿◉●•◦</b>"
	       # Remove Compile zip
	       rm -rf $file
	fi
}
#*********************************************************************************************************#
vanilla_build
