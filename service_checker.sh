#!/bin/bash
while true;
do
    read -p "Enter service name: " service_name
    systemctl status -q "$service_name" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        break
    else
        "❌❌❌ Service $service_name doesn't exists. Try another one ❌❌❌"
    fi
done 

status=$(systemctl is-active "$service_name") 
if [ "$status" = "active" ]; then
    echo "🟢🟢🟢 Service $service_name is active 🟢🟢🟢"
else
    echo "🔴🔴🔴 Service $service_name is inactive 🔴🔴🔴"
fi