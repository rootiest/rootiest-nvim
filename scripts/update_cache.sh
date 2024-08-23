#!/bin/bash

# Separator variable
separator="␟"

# Ignored player sources for music
ignored_players=(
	"chromium"
	"firefox"
	"kdeconnect"
	"haruna"
	"plasma-browser-integration"
)

# Convert array to a comma-separated string with no spaces
ignored_sources=$(
	IFS=,
	echo "${ignored_players[*]}"
)

# Lock file path
lock_file="/tmp/music_wakatime_update.lock"

# Create a lock file to ensure only one instance of the script runs
if [[ -e $lock_file ]]; then
	echo "Another instance of this script is already running."
	exit 1
else
	# Create the lock file
	touch "$lock_file"
fi

# Function to clean up lock file on exit
cleanup() {
	rm -f "$lock_file"
}
trap cleanup EXIT

# Update the music cache file every second
while true; do
	playerctl --ignore-player ${ignored_sources} metadata --format "{{ artist }}${separator}{{ title }}${separator}{{ album }}${separator}{{ status }}${separator}{{ volume }}${separator}{{ loop }}${separator}{{ shuffle }}" >~/.cache/music_cache.txt
	sleep 1
done & # Run this loop in the background

# Update the Wakatime cache file every 60 seconds
while true; do
	~/.wakatime/wakatime-cli --today >~/.cache/wakatime_cache.txt 2>/dev/null
	sleep 60
done & # Run this loop in the background

# Wait for all background processes to finish
wait
