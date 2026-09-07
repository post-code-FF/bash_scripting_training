#!/bin/bash

password="burmalda"
username="admin"

read -p "Enter the username: " username_input 
read -sp "Enter the password: " password_input
if [ "$username" == "$username_input" ] && [ "$password" = "$password_input" ]; then
	echo "Welcome!"
else
	echo "Wrong username or password"
fi
