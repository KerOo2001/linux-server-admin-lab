#!/bin/bash

set -e

LAB_DIR="/opt/acl-lab"

echo "=== RH134 CH04: ACL Lab ==="

if [[ ! -d "$LAB_DIR" ]]; then
    echo "ERROR: Lab directory not found."
    exit 1
fi

echo "=== Directory Permissions ==="
ls -ld "$LAB_DIR"

echo "=== Directory ACL ==="
getfacl "$LAB_DIR"

echo "=== File ACL ==="
if [[ -f "$LAB_DIR/inherited.txt" ]]; then
    getfacl "$LAB_DIR/inherited.txt"
else
    echo "Inherited test file not found."
fi

echo "=== ACL Lab Verification Completed ==="
