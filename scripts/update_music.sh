#!/bin/bash
# Separator variable
separator="␟"

# Update the cache file every second
while true; do
  playerctl --ignore-player firefox,kdeconnect,haruna,plasma-browser-integration metadata --format "{{ artist }}${separator}{{ title }}${separator}{{ album }}${separator}{{ status }}${separator}{{ volume }}${separator}{{ loop }}${separator}{{ shuffle }}" >~/.cache/music_cache.txt
  sleep 1
done
