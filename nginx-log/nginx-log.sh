#!/bin/bash

# Check argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <nginx-access-log>"
    exit 1
fi

LOGFILE=$1

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File not found."
    exit 1
fi

echo "========================================="
echo "NGINX LOG ANALYSIS REPORT"
echo "========================================="
echo

# Top 5 IP Addresses
echo "Top 5 IP Addresses:"
awk '{print $1}' "$LOGFILE" \
| sort \
| uniq -c \
| sort -rn \
| head -5
echo

# Top 5 Requested Paths
echo "Top 5 Requested Paths:"
awk -F'"' '{print $2}' "$LOGFILE" \
| awk '{print $2}' \
| sort \
| uniq -c \
| sort -rn \
| head -5
echo

# Top 5 Status Codes
echo "Top 5 Response Status Codes:"
awk '{print $9}' "$LOGFILE" \
| sort \
| uniq -c \
| sort -rn \
| head -5
echo

# Top 5 User Agents
echo "Top 5 User Agents:"
awk -F'"' '{print $6}' "$LOGFILE" \
| sort \
| uniq -c \
| sort -rn \
| head -5
echo

echo "========================================="
echo "END OF REPORT"
echo "========================================="