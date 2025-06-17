#!/bin/bash

# Prompt user for login and password
read -p "Enter your login: " LOGIN
read -s -p "Enter your password: " PASSWORD
echo

# Combine and encode
TOKEN=$(echo -n "$LOGIN:$PASSWORD" | openssl base64)

# Output result
echo "Your Base64-encoded token is:"
echo "$TOKEN"
