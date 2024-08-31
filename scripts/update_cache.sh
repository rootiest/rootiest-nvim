#!/bin/bash

# Separator variable
separator="␟"

# Ignored player sources for music
ignored_sources=""

# Flags for disabling functionality
disable_wakatime=false
no_music=false

# Function to print usage
print_usage() {
	echo "Usage: $0 [OPTION]..."
	echo "Options:"
	echo "  -h, --help              Print this help message and exit"
	echo "  -i, --ignore            Comma-separated list of sources to ignore"
	echo "  -d, --disable-wakatime  Disable wakatime integration"
	echo "  -n, --no-music          Disable music integration"
	exit 0
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
	case "$1" in
	-h | --help)
		print_usage
		;;
	-i | --ignore)
		if [[ -n $2 && $2 != -* ]]; then
			ignored_sources=$2
			shift
		else
			echo "Error: --ignore requires an argument."
			exit 1
		fi
		;;
	-d | --disable-wakatime)
		disable_wakatime=true
		;;
	-n | --no-music)
		no_music=true
		;;
	*)
		echo "Unknown option: $1"
		print_usage
		;;
	esac
	shift
done

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

# Update the music cache file every second, if not disabled
if ! $no_music; then
	while true; do
		playerctl --ignore-player "${ignored_sources}" metadata --format "{{ artist }}${separator}{{ title }}${separator}{{ album }}${separator}{{ status }}${separator}{{ volume }}${separator}{{ loop }}${separator}{{ shuffle }}" >~/.cache/music_cache.txt
		sleep 1
	done & # Run this loop in the background
fi

# Update the Wakatime cache file every 60 seconds, if not disabled
if ! $disable_wakatime; then
	while true; do
		~/.wakatime/wakatime-cli --today >~/.cache/wakatime_cache.txt 2>/dev/null
		sleep 60
	done & # Run this loop in the background
fi

# Wait for all background processes to finish
wait
