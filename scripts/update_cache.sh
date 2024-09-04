#!/bin/bash

# Separator variable
separator="␟"

# Ignored player sources for music
ignored_sources=""

# Flags for disabling functionality
disable_wakatime=false
no_music=false
custom_cache_dir=""

# Function to print usage
print_usage() {
	echo "Usage: $0 [OPTION]..."
	echo "Options:"
	echo "  -h, --help              Print this help message and exit"
	echo "  -i, --ignore            Comma-separated list of sources to ignore"
	echo "  -d, --disable-wakatime  Disable wakatime integration"
	echo "  -n, --no-music          Disable music integration"
	echo "  -c, --cache-dir         Specify a custom cache directory"
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
	-c | --cache-dir)
		if [[ -n $2 && $2 != -* ]]; then
			custom_cache_dir=$2
			shift
		else
			echo "Error: --cache-dir requires an argument."
			exit 1
		fi
		;;
	*)
		echo "Unknown option: $1"
		print_usage
		;;
	esac
	shift
done

# Use custom cache directory if provided, else use Neovim's cache directory
cache_dir="${custom_cache_dir:-\
		  ${NVIM_CACHE_DIR:-\
		  ${XDG_CACHE_HOME:-$HOME/.cache}/nvim}}"
mkdir -p "$cache_dir"

# Lock file path
lock_file="$cache_dir/music_wakatime_update.lock"

# Create a lock file to ensure only one instance of the script runs
if [[ -e $lock_file ]]; then
	echo "Another instance of this script is already running."
	exit 1
else
	touch "$lock_file"
fi

# Function to clean up lock file on exit
cleanup() {
	rm -f "$lock_file"
}
trap cleanup EXIT

# Check if playerctl is available
if ! command -v playerctl &>/dev/null; then
	echo "Warning: playerctl not found. Disabling music integration."
	no_music=true
fi

# Check if wakatime-cli is available
if ! command -v wakatime-cli &>/dev/null; then
	echo "Warning: wakatime-cli not found. Disabling wakatime integration."
	disable_wakatime=true
fi

# Update the music cache file every second, if not disabled
if ! $no_music; then
	while true; do
		playerctl --ignore-player "${ignored_sources}" \
			metadata \
			--format "{{ artist }}${separator}{{ title }}${separator} \
{{ album }}${separator}{{ status }}${separator}{{ volume }}${separator} \
{{ loop }}${separator}{{ shuffle }}" \
			>"$cache_dir/music_cache.txt"
		sleep 1
	done & # Run this loop in the background
fi

# Update the Wakatime cache file every 60 seconds, if not disabled
if ! $disable_wakatime; then
	while true; do
		wakatime-cli --today >"$cache_dir/wakatime_cache.txt" 2>/dev/null
		sleep 60
	done & # Run this loop in the background
fi

# Wait for all background processes to finish
wait
