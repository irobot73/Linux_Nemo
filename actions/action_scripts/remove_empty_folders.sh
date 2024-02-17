#!/usr/bin/bash

if find "$1" -type d -empty -delete; then
    notify-send --expire-time=200000 "Empty folder(s) removed from '$1'."
else
    notify-send --expire-time=200000 "No empty folders found to remove."
fi
