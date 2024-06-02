#!/bin/bash
# Copyright (c) 2016-2024 Crave.io Inc. All rights reserved

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "gh could not be found. Installing gh..."
    curl -sS https://webi.sh/gh | sh
    source ~/.config/envman/PATH.env
    echo "gh installed."
fi

# Authenticate against github.com by reading the token from a img_file
rm -rf token.txt
echo "$ght" > token.txt && gh auth login --with-token < token.txt

GH="https://github.com/Sa-Sajjad/recovery_lavender"
FP=$(ls out/target/product/*/*.img | head -n 1) # Use ls to expand the glob pattern and pick the first match
FP2=$(ls out/target/product/*/*.zip | head -n 1) # Use ls to expand the glob pattern and pick the first match

if [ -z "$FP" ]; then
    echo "No zip file found in the specified directory."
    exit 1
fi

FN=$(basename "$FP")
FZ=$(basename "$FP" | awk -F- '{print $1}')-$(date +"%d-%m-%Y")
echo -e "$FZ"
echo -e "Start uploading file on github..."

gh release create "$FZ" --generate-notes --repo "$GH"
gh release upload "$FZ" --repo "$GH" "$FP"
