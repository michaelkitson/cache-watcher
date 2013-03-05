cache-watcher
=============

A simple bash script to save mp4 files that show up in my browser cache (songs from songza.com)

Nothing too serious, just something I hacked together at three in the morning when I realized that songza doesn't set the no-cache header.
This could easily change in the future, so be warned, this will probably break. If I notice, I'll put up a warning or try to fix it.

The script will dump the files into a given folder as <artist>/<album>/<title>.m4a
Beware, the songs aren't super quality or anything, don't be so picky.

Requirements
------------
* inotifywait - To watch for files that are closed after having been written to in the browser cache
* avconv - To grab embedded song metadata
* iconv - Because the song metadata is in a terrible text encoding
