#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved
if [ ! -f token.txt ]; then
    echo "token.txt doesn't exist!. Creating token.txt"
    echo "$ght" > token.txt
else
    echo "token.txt already available"
fi

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "gh could not be found. Installing gh..."
    curl -sS https://webi.sh/gh | sh
    source ~/.config/envman/PATH.env
    echo "gh installed."
fi

: ${GH_UPLOAD_LIMIT:=2147483648}
echo "Upload Limit is set to $GH_UPLOAD_LIMIT"
# Scan Release IMG_FILES
for img_file in out/target/product/$device/*.img; do
    if [[ -n $img_file && $(stat -c%s "$img_file") -le $GH_UPLOAD_LIMIT ]]; then # Try to match github releases per size limit
        IMG_FILES+="$img_file "
        echo "Selecting $img_file for Upload"
    else
        echo "Skipping $img_file"
    fi
done
echo "Image Files to be uploaded: $IMG_FILES"

# Now do the same for ZIP_FILES
for zip_file in out/target/product/$device/*.zip; do
    if [[ -n $zip_file && $(stat -c%s "$zip_file") -le $GH_UPLOAD_LIMIT ]]; then # Try to match github releases per size limit
        ZIP_FILES+="$zip_file "
        echo "Selecting $zip_file for Upload"
    else
        echo "Skipping $zip_file"
    fi
done
echo "Zip Files to be uploaded: $ZIP_FILES"
echo "Extra Files to be uploaded: $EXTRAFILES"

# Authenticate against github.com by reading the token from a img_file
gh auth login --with-token < token.txt

GH="https://github.com/Sa-Sajjad/recovery_lavender"
FP=$(ls out/target/product/*/*.img | head -n 1) # Use ls to expand the glob pattern and pick the first match

if [ -z "$FP" ]; then
    echo "No zip file found in the specified directory."
    exit 1
fi

FZ=$(basename "$FP" | awk -F- '{print $1}')-$(( RANDOM - ( RANDOM % RANDOM ) ))-$(date +"%d-%m-%Y")
echo -e "$FZ"
echo -e "Start uploading file on github..."

gh release create "$FZ" --generate-notes --repo "$GH"
gh release upload "$FZ" --repo "$GH" "$ZIP_FILES" "$IMG_FILES"

gh release upload 
