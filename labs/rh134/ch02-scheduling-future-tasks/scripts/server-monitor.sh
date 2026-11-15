#!/bin/bash

exec > monitor-report.txt


SERVER=$(hostname)
DATE=$(date)

echo "================================="
echo "       SERVER MONITOR REPORT"
echo "================================="

echo "Hostname: $SERVER"
echo "Date: $DATE"

echo ""
echo "-------- SERVICE STATUS --------"

# Services to monitor
SERVICES="httpd sshd cups"

for SERVICE in $SERVICES
do
	if systemctl is-active --quiet "$SERVICE"; then
	echo "SUCCESS: $SERVICE is running"
    else
        echo "WARNING: $SERVICE is not running"
	fi
done

echo "================================="
echo "       END OF REPORT"
echo "================================="
