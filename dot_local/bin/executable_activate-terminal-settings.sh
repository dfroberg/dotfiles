#!/bin/bash

# Get startupActions
STARTUPACTIONS=$(~/.local/bin/create-terminal-settings.sh)
#echo $STARTUPACTIONS

# patch settings.json using jq in C:\Users\danny\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState converted to WSL /mnt/c/Users/danny/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json
export SETTINGSPATH="/mnt/c/Users/danny/AppData/Local/Packages/Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe/LocalState/settings.json"
jq --arg STARTUPACTIONS "$STARTUPACTIONS" '.startupActions = $STARTUPACTIONS' $SETTINGSPATH > $SETTINGSPATH.tmp && mv $SETTINGSPATH.tmp $SETTINGSPATH

# Patch settings.json section profiles startupActions
