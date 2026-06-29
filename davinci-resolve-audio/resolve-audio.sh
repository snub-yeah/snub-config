#!/usr/bin/env fish

if test (count $argv) -ne 1
    echo "Usage: resolve-audio <video-url>"
    exit 1
end

if not type -q yt-dlp
    echo "Error: yt-dlp is not installed or not on PATH."
    exit 1
end

if not type -q ffmpeg
    echo "Error: ffmpeg is not installed or not on PATH."
    exit 1
end

yt-dlp \
    --no-playlist \
    --format bestaudio/best \
    --extract-audio \
    --audio-format wav \
    --postprocessor-args "ExtractAudio:-c:a pcm_s16le -ar 48000 -ac 2" \
    --output "%(title)s.%(ext)s" \
    "$argv[1]"
