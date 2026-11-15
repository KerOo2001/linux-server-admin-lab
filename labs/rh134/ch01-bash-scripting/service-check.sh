#!/bin/bash

SERVICE="httpd"

if systemctl is-active --quiet "$SERVICE"; then
	echo "SUCCESS: $SERVICE is running"
else
	echo "WARNING: $SERVICE is not running"
fi
