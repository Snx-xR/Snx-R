#!/usr/bin/env bash
#
#   orangefox-env.sh - OrangeFox Recovery Build Environment
#   Copyright (C) 2023-2025 The OrangeFox Recovery Project
#
#   This software is released under GPL version 3 or later
#   https://www.gnu.org/licenses/gpl-3.0.html
#

# Screen and UI configuration
export OF_SCREEN_H=2340
export OF_STATUS_H=80
export OF_STATUS_INDENT_LEFT=64
export OF_STATUS_INDENT_RIGHT=64
export OF_HIDE_NOTCH=1
export OF_CLOCK_POS=1

# LED configuration
export OF_USE_GREEN_LED=0

# Treble and partition compatibility
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_UNBIND_SDCARD_F2FS=1
export OF_ENABLE_ALL_PARTITION_TOOLS=1

# Keymaster version
export OF_DEFAULT_KEYMASTER_VERSION=4.0

# AVB and MIUI handling
export OF_PATCH_AVB20=1
export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1

# OTA and logging options
export OF_DISABLE_OTA_MENU=1
export OF_DONT_KEEP_LOG_HISTORY=1

# UI settings
export OF_OPTIONS_LIST_NUM=9

# Quick backup partitions
export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"

# Legacy fixes
export OF_USE_LEGACY_TIME_FIXUP=1
echo "env exported"