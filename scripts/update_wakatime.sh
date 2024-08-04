#!/bin/bash

# Update the cache file with the Wakatime CLI command
while true; do
  ~/.wakatime/wakatime-cli --today >~/.cache/wakatime_cache.txt 2>/dev/null
  sleep 60
done
