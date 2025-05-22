source build/envsetup.sh
export TZ=Asia/Dhaka
export SELINUX_IGNORE_NEVERALLOWS=true
brunch lavender
bash <(curl -s https://raw.githubusercontent.com/Sushrut1101/GoFile-Upload/refs/heads/master/upload.sh) out/target/product/*/*.zip || curl -O https://raw.githubusercontent.com/Sushrut1101/GoFile-Upload/refs/heads/master/upload.sh && upload.sh out/target/product/*/*.zip
