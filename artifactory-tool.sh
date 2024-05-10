#!/bin/bash

# Prompt user for license key
echo "Please enter your license key:"
read LICENSE

# Use the provided license key to make a POST request and extract the token
TOKEN=$(curl -s -X POST \
               -H "Content-Type: application/json" \
               -H "Accept: */*" \
               -d "{\"key\": \"$LICENSE\", \"host_name\": \"$(hostname)\"}" \
               https://cln.cloudlinux.com/cln/api/centos/token/register | grep -oP '"token":"\K[\w\d-]*')

# Check if the token was successfully captured
if [ -z "$TOKEN" ]; then
    echo "Failed to retrieve token. Please check your license key and try again."
else
    echo "Token retrieved successfully: $TOKEN"

    # Generate URLs with the token and display them
    echo "URLs for customer:"
    echo "1. https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/x86_64/"
    echo "2. https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/i686/"
    echo "3. https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/i386/"
fi
