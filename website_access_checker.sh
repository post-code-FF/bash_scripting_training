#!/bin/bash

while true;
do
    read -p "Enter website url: " url
    ping -c 4 "$url" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅✅✅ Website $url is available ✅✅✅"
    else
        echo "❌❌❌ Website $url is unavailable ❌❌❌"
    fi
done 


