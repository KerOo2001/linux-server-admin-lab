#!/bin/bash

#Services to monitor
SERVICES="httpd sshd cups"

#Check each service

for SERVICE in $SERVICES
do
	if systemctl is-active --quiet "$SERVICE"; then
		echo "SUCCESS: $SERVICE is running"
	else
		echo"WARNING: $SERVICE is not running"
	fi
done
