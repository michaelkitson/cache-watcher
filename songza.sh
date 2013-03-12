#!/bin/bash

# Watches a folder (like a browser cache) for mp4 files
# When one is found, it renames it and places it into a music library at
# artist/album/title.m4a
#
# Requires avconv, iconv, and inotifywait to be installed and $HOME to be set

CACHE_FOLDER="$HOME/.cache/chromium/Default/Cache"
SONG_STORE="$HOME/Music/songza"
inotifywait -m -e close_write --format '%f' $CACHE_FOLDER | while read line
do
    original="$CACHE_FOLDER/$line"
    if [ -n `file $original | \grep --count 'MPEG v4'` ]; then
        metadata=$(avconv -i $original 2>&1 | iconv -f WINDOWS-1252)
        title=$(echo  "$metadata" | \grep -P '^\s+title\s+:\s'  | cut -d':' -f 2 | sed 's/^ //')
        artist=$(echo "$metadata" | \grep -P '^\s+artist\s+:\s' | cut -d':' -f 2 | sed 's/^ //')
        album=$(echo  "$metadata" | \grep -P '^\s+album\s+:\s'  | cut -d':' -f 2 | sed 's/^ //')
        if [[ -n $title && -n $artist && -n $album ]]; then
            folder="$SONG_STORE/$artist/$album"
            newFile="$folder/$title.m4a"
            mkdir -p "$folder"
            if [ ! -f "$newFile" ]; then
                echo "Added $title by $artist"
            fi
            cp "$original" "$newFile"
        fi
    fi
done
