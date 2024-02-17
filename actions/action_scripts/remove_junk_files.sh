#!/usr/bin/bash
timeout=5
echo "Removing 'junk' (.jpg, *.nfo, .txt, *.url) files."

for (( i=0 ; i <= $timeout ; i++ )) do 
    echo "# Commencing in $[ $timeout - $i ]..."
    echo $[ 100 * $i / $timeout ]
    sleep 1
done | zenity --progress --title="Cancel?"  \
    --window-icon=warning --width=400 --auto-close

result=$?

if [ $result = -1 ] ; then #An unexpected error has occurred.
    notify-send --expire-time=200000 "Error occured."
elif [ $result = 0 ] ; then #The user has pressed either OK or Close.
    find "$1" -type f \( -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.nfo' -o -iname '*.txt' -o -iname '*.url' \) -delete
    notify-send --expire-time=200000 "Successfully cleaned $1."
elif [ $result = 1 ] ; then #The user has either pressed Cancel, or used the window functions to close the dialog.
    notify-send --expire-time=200000 "Cancel pressed."
elif [ $result = 5 ] ; then #The dialog has been closed because the timeout has been reached.
    notify-send --expire-time=200000 "Timeout reached."
else 
    notify-send --expire-time=200000 "Unknown error in $0."
fi
