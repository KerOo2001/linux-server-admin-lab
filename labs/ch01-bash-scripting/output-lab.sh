#!/bin/bash

echo "=============================="
echo "       SERVER REPORT"
echo "=============================="


SERVER_NAME=$(hostname)

CURRENT_USER=$(whoami)

DATE=$(date)

echo "Server Information"

printf "Server: %s\n" "$SERVER_NAME"

printf "User: %s\n" "$CURRENT_USER"

printf "Date: %s\n" "$DATE"
