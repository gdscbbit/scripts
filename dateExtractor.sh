#!/bin/bash

# Specify the input file containing the Google Cloud Skill Boost profile URLs. For more info, refer to the readme.
INPUT_FILE="URLs.txt"

# Check if the file exists
if [[ ! -f "$INPUT_FILE" ]]; then
    echo "File not found: $INPUT_FILE"
    exit 1
fi

# Read each URL from the file and process it
while IFS= read -r URL; do
    # Fetch the webpage content and extract the date
    DATE=$(curl -s "$URL" | grep -oP "Earned \K.*?(?= EDT)" | head -n 1)

    # Print the extracted date with the URL
    if [ -n "$DATE" ]; then
        echo "URL: $URL - Completion Date: $DATE"
    else
        echo "URL: $URL - Date not found."
    fi
done < "$INPUT_FILE"

