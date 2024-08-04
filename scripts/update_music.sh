#!/bin/bash
# Update the cache file every second
while true; do
  playerctl --ignore-player firefox,kdeconnect,plasma-browser-integration metadata --format '{{ artist }} - {{ title }} - {{ album }} - {{ status }}' >~/.cache/music_cache.txt
  sleep 1
done
