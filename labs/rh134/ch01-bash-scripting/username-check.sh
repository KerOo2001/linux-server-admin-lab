#!/bin/bash

read -r -p "Enter username: " USERNAME

if [[ -z "$USERNAME" ]]; then
	echo "ERROR: Username cannot be empty"
	exit 1
else
	echo "Welcome, $USERNAME!"
	exit 0
fi
