#!/bin/bash

# Check if input_dir and output_dir arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_m4a_dir> <output_mp4_dir>"
    exit 1
fi

# where there are m4a files.
input_dir="$1"

# where the mp4 files will go
output_dir="$2"

# Check if the input directory exists
if [ ! -d "$input_dir" ]; then
    echo "Error: Input directory '$input_dir' not found."
    exit 1
fi

# Check if the output directory exists; create it if it doesn't
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Loop through all M4A files in the input directory
for input_file in "$input_dir"/*.m4a; do
    if [ -f "$input_file" ]; then
        # Extract the filename without extension
        filename=$(basename "$input_file" .m4a)
        
        # Construct the output file path
        output_file="$output_dir/${filename}.mp4"
        
        # Run the FFmpeg command to convert the M4A to MP4
        
        ffmpeg -i "$input_file" -c:v libx264 -c:a aac -strict experimental -b:a 192k -shortest "$output_file"
        
        echo "Converting '$input_file' to '$output_file'"
    fi
done

echo "Conversion completed."




