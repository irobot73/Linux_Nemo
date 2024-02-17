#!/bin/bash

TARGET="${1}"
FULL_PARENT_PATH="$(dirname "$TARGET")"
PARENT_FOLDER_NAME=${TARGET##*/}

#mv {,new.}original.filename
while IFS= read -r -d '' -u 9
do
    BASE_FILE_NAME="$(basename "$REPLY")"
    #echo $BASE_FILE_NAME
    NO_EXT="${BASE_FILE_NAME%.*}"
    EXT="${REPLY##*.}"
    NEW_FILE_NAME="$1/$PARENT_FOLDER_NAME - $NO_EXT - .$EXT"
    #echo $NEW_FILE_NAME
    mv "$REPLY" "$NEW_FILE_NAME"
done 9< <( find "$TARGET" -type f -exec printf '%s\0' {} + )

notify-send --expire-time=300000  "Parent prefixed to filename(s) complete"
