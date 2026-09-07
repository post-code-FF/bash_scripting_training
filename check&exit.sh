#!/bin/bash

if systemctl status -q "$1" > /dev/null 2>&1; then
    echo "Service $1 is running"
    exit 0
else
    echo "Service $1 is down"
    exit 1
fi