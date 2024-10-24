#!/bin/bash

print_directory_structure() {
    local directory="$1"
    local prefix="$2"

    # Print the current directory name
    echo "${prefix}$(basename "$directory")/"

    # Get a list of files and directories in the current directory
    local entries=("$directory"/*)

    # Iterate over each entry
    for i in "${!entries[@]}"; do
        local entry="${entries[$i]}"
        local new_prefix="${prefix}│   "

        # If it's the last entry, adjust the prefix
        if [ "$i" -eq $((${#entries[@]} - 1)) ]; then
            new_prefix="${prefix}    "
        fi

        if [ -d "$entry" ]; then
            # If it's a directory, recurse into it
            echo "${prefix}├── $(basename "$entry")/"
            print_directory_structure "$entry" "$new_prefix"
        else
            # If it's a file, print the file name
            echo "${prefix}└── $(basename "$entry")"
        fi
    done
}

# Start from the current directory or a provided directory
start_directory="${1:-.}"
print_directory_structure "$start_directory"
