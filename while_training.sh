#!/bin/bash
password="burmalda"
username="admin"

while true;
do
    read -p "Enter the username: " username_input
    read -sp "Enter the password: " password_input
    echo 
    if [[ $username_input == $username && $password_input == $password ]]; 
    then
        echo "Welcome!"
        break
    else
        echo "Username or password incorrect. Try again."
    fi
done
