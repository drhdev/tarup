#!/bin/bash
#
# Name: tarup.sh
# Version: 0.1
# License: GPL 3.0
# Description: This script creates a tarball of the current directory with optional exclusions.
#              It allows you to select predefined exclusion sets or specify custom exclusions.
#              The output tarball can be named and placed in a specific location.
#
# Installation:
# 1. Save the script to your desired location.
# 2. Change the permissions to make it executable:
#      chmod +x tarup.sh
#
# Usage:
# 1. To run with default settings (all exclusions and default output file):
#      ./tarup.sh
# 2. To run with no exclusions:
#      ./tarup.sh -e none
# 3. To run with custom exclusions:
#      ./tarup.sh -e custom -e "*.log,.cache,.env"
# 4. To specify the output file location and name:
#      ./tarup.sh -o /path/to/output/file.tar.gz
# 5. Display help:
#      ./tarup.sh -h or ./tarup.sh -help
#

# Get the current date
CURRENT_DATE=$(date +"%Y%m%d")

# Get the hostname (server name)
SERVER_NAME=$(hostname)

# Get the current directory name
DIRECTORY_NAME=$(basename "$PWD")

# Set default output file name
OUTPUT_FILE="${CURRENT_DATE}_tarup_${SERVER_NAME}_${DIRECTORY_NAME}.tar.gz"

# Default exclusions
EXCLUSIONS=(
    "_old"
    "scraped"
    "venv"
    "*.cache"
    "._*"
    "*.DS_Store"
    "*.Thumbs.db"
    ".local"
    ".config"
    ".pki"
    ".env"
    ".gitignore"
)

# Function to build exclusion parameters for tar command
build_exclusions() {
    local exclude_list=("$@")
    local exclude_params=()
    for exclude in "${exclude_list[@]}"; do
        exclude_params+=("--exclude=${exclude}")
        exclude_params+=("--exclude=*/${exclude}")
    done
    echo "${exclude_params[@]}"
}

# Function to display help
show_help() {
    echo "Usage: tarup.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -e [none|all|custom]          Specify exclusion set:"
    echo "                                none   - No exclusions"
    echo "                                all    - Full set of exclusions (default)"
    echo "                                custom - Provide a custom list of exclusions (comma-separated)"
    echo "  -o [output_file]              Specify the output tar.gz file path and name"
    echo "  -h, -help                     Display this help message"
    echo ""
    echo "Default behavior:"
    echo "  If no options are provided, the script will use the 'all' exclusion set and"
    echo "  the output file will be named '${CURRENT_DATE}_tarup_${SERVER_NAME}_${DIRECTORY_NAME}.tar.gz'"
    echo "  in the current directory."
    echo ""
    echo "Example usage:"
    echo "  ./tarup.sh -e custom -e \"*.log,.cache,.env\" -o /path/to/output/file.tar.gz"
    echo "  ./tarup.sh -o /path/to/output/file.tar.gz"
}

# Parse options
while getopts ":e:o:hhelp" opt; do
    case $opt in
        e) 
            case $OPTARG in
                none)
                    EXCLUSIONS=()
                    ;;
                all)
                    EXCLUSIONS=(
                        "_old"
                        "scraped"
                        "venv"
                        "*.cache"
                        "._*"
                        "*.DS_Store"
                        "*.Thumbs.db"
                        ".local"
                        ".config"
                        ".pki"
                        ".env"
                        ".gitignore"
                    )
                    ;;
                custom)
                    IFS=',' read -r -a EXCLUSIONS <<< "$OPTARG"
                    ;;
                *)
                    echo "Invalid exclusion option. Use none, all, or custom."
                    exit 1
                    ;;
            esac
            ;;
        o) 
            OUTPUT_FILE="$OPTARG"
            ;;
        h|help)
            show_help
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done

# Shift the parsed options
shift $((OPTIND-1))

# Get the absolute path of the output file
OUTPUT_FILE_ABS=$(realpath "$OUTPUT_FILE")

# Add the output file itself to the exclusions
EXCLUSIONS+=("$OUTPUT_FILE_ABS")

# Build exclusion parameters
EXCLUDE_PARAMS=$(build_exclusions "${EXCLUSIONS[@]}")

# Execute the tar command
tar $EXCLUDE_PARAMS -czvf "$OUTPUT_FILE" "$PWD"
