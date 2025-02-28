#!/usr/bin/env bash

clear
echo "****************************************************************************"
echo "Title: TuxCare .Net6 Activation Script v1.0"
echo "Purpose: Register Artifactory Tool to TuxCare and provide URLs"
echo "Created by: Jamie Charleston | Last updated: 02/28/2025"
echo ""
echo "By continuing, you agree to the TuxCare EULA (https://tuxcare.com/legal/)."
echo "****************************************************************************"

# User agreement
read -p "Do you agree to these terms? (y/n): " response
[[ "$response" != "y" ]] && echo "Exiting." && exit 1

# License key input
read -p "Enter your license key: " LICENSE
[[ -z "$LICENSE" ]] && echo "License key required!" && exit 1

# Define API URL
CLN_REGISTER_SERVER="https://cln.cloudlinux.com/cln/api/els/server/register"

# Get hostname
HOSTNAME=$(hostname)

# Request registration token
CLN_REGISTER=$(curl -s -X POST -H "Content-Type: application/json" -H "accept: */*" \
    -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" "$CLN_REGISTER_SERVER")

# Extract token from response
TOKEN=$(echo "$CLN_REGISTER" | grep -oP '"token":"\K[\w\d-]*')

# Validate token retrieval
[[ -z "$TOKEN" ]] && echo "Error: Token not received." && exit 1

# Generate the correct tokenized repository URL
TOKENIZED_URL="https://windows.tuxcare.com/dotnet/${TOKEN}/6.0/"

# Output result
echo ""
echo "Successfully Activated. Your repository URL:"
echo "$TOKENIZED_URL"
echo "Save it securely."
