#!/bin/bash

#Chech if a directory exists

ls /tmp > /dev/null 2>&1

STATUS=$?

if [ "$STATUS" -eq 0 ]; then
	echo "SUCCESS: Directory is accessible"
else
echo "ERROR: Cannot access directory"
fi
