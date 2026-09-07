#!/bin/bash

services=("docker" "nginx" "sshd")

for service in "${services[@]}"; do
    systemctl status -q "$service" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Service $service is OK"
    else
        echo "Service $service is down"
    fi
done

        