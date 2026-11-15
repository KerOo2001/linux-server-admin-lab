#!/bin/bash

# Collect system information
SERVER_NAME=$(hostname)
CURRENT_USER=$(whoami)
DATE=$(date)

# Display report header
echo "=============================="
echo "       SERVER REPORT"
echo "=============================="

# Display system information
printf "Server: %s\n" "$SERVER_NAME"
printf "User: %s\n" "$CURRENT_USER"
printf "Date: %s\n" "$DATE"
