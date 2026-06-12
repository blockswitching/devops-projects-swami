#!/bin/bash

# Check argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1

# Verify directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

# Create archive directory
ARCHIVE_DIR="./archives"
mkdir -p "$ARCHIVE_DIR"

# Timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Archive filename
ARCHIVE_FILE="logs_archive_${TIMESTAMP}.tar.gz"

# Compress logs
tar -czf "${ARCHIVE_DIR}/${ARCHIVE_FILE}" "$LOG_DIR"

# Verify success
if [ $? -eq 0 ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Archived $LOG_DIR -> $ARCHIVE_FILE" >> archive.log
    echo "Archive created:"
    echo "${ARCHIVE_DIR}/${ARCHIVE_FILE}"
else
    echo "Archive failed."
    exit 1
fi