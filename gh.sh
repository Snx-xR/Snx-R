#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# Check for token.txt file and create if it doesn't exist
if [ ! -f token.txt ]; then
    echo "token.txt doesn't exist! Creating token.txt"
    echo "$ght" > token.txt
else
    echo "token.txt already available"
fi

# Check if gh CLI is installed, and install if not
if ! command -v gh &> /dev/null; then
    echo "gh could not be found. Installing gh..."
    curl -sS https://webi.sh/gh | sh
    source ~/.config/envman/PATH.env
    echo "gh installed."
fi

# Set default upload limit if not already set
: ${GH_UPLOAD_LIMIT:=2147483648}
echo "Upload Limit is set to $GH_UPLOAD_LIMIT"

# Initialize arrays for image and zip files
IMG_FILES=()
ZIP_FILES=()

# Scan for image files only if they exist
if ls out/target/product/$device/*.img &> /dev/null; then
    for img_file in out/target/product/$device/*.img; do
        if [[ -n $img_file && $(stat -c%s "$img_file") -le $GH_UPLOAD_LIMIT ]]; then
            IMG_FILES+=("$img_file")
            echo "Selecting $img_file for Upload"
        else
            echo "Skipping $img_file"
        fi
    done
else
    echo "No image files found in the specified directory."
fi
echo "Image Files to be uploaded: ${IMG_FILES[@]}"

# Scan for zip files only if they exist
if ls out/target/product/$device/*.zip &> /dev/null; then
    for zip_file in out/target/product/$device/*.zip; do
        if [[ -n $zip_file && $(stat -c%s "$zip_file") -le $GH_UPLOAD_LIMIT ]]; then
            ZIP_FILES+=("$zip_file")
            echo "Selecting $zip_file for Upload"
        else
            echo "Skipping $zip_file"
        fi
    done
else
    echo "No ZIP files found in the specified directory."
fi
echo "Zip Files to be uploaded: ${ZIP_FILES[@]}"
echo "Extra Files to be uploaded: $EXTRAFILES"

# Authenticate GitHub CLI
if ! gh auth login --with-token < token.txt; then
    echo "Failed to authenticate with GitHub"
    exit 1
fi

# Define GitHub repository
GH="https://github.com/Sa-Sajjad/Action-OFRP-Builder"

# Create a unique release tag
FP=$(ls out/target/product/$device/*.img | head -n 1) # Use ls to expand the glob pattern and pick the first match

if [ -z "$FP" ]; then
    echo "No image file found in the specified directory."
    exit 1
fi

FZ=$(basename "$FP" | awk -F- '{print $1}')-FBE_V2-$(date '+%Y%m%d')
echo -e "$FZ"
echo -e "Start uploading file on github..."

# Create release and upload files
if gh release create "$FZ" --generate-notes --repo "$GH"; then
    gh release upload "$FZ" --repo "$GH" "${ZIP_FILES[@]}" "${IMG_FILES[@]}"
else
    echo "Failed to create GitHub release"
    exit 1
fi
