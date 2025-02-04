#!/usr/bin/env bash

clear
echo "****************************************************************************"
echo  "Title: TuxCare ELS Artifactory Registration Script."
echo  "Purpose: Register Artifactory Tool to TuxCare and provide URls"
echo "         for Artifactory Configuration."
echo  "Created by: Jamie Charleston" 
echo  "Version: 1.5"
echo  "Last updated: 05/16/2024"
echo ""
echo  "Terms: By using this script to register your server, you agree that all"
echo  "       servers connecting to your Artifactory have been counted and that count"
echo  "       has been provided to your TuxCare Account Manager. If that number changes"
echo  "       as it pertains for your specific contract you agree to provide updates to"
echo  "       your account manager. By continueing forward with using this tool and"
echo  "       registering your Artifactory you agree to be bound by the TuxCare EULA"
echo  "       (https://tuxcare.com/legal/) or customized MSSA."
echo  ""
echo  "Disclaimer:"
echo  "This script is provided "AS IS" and without warranty of any kind."
echo  "You, the user, assume any risks associated with the use of this script."
echo  "You are solely responsible for the use and misuse of this script."
echo  "You agree to indemnify and hold harmless the creator of this script"
echo  "from any and all claims arising from your use or misuse of the script."
echo "****************************************************************************"

# Prompt the user to agree to the terms
read -p "Do you agree to these terms? (y/n): " response

# Check if the user agreed to the terms
if [ "$response" != "y" ]; then
  echo "You did not agree to the terms. Exiting script."
  exit 1
fi

# Proceed with the script
echo "Thank you for agreeing to the TOS. Please continue."


# Define the server URL and retrieve the hostname
CLN_SERVER="https://cln.cloudlinux.com/cln/api/els/server/register"
HOSTNAME=$(hostname)

# Ask for the license key
read -p "Enter your license key: " LICENSE

# Check if the license key is empty
if [[ -z "$LICENSE" ]]; then
    echo "License key cannot be empty!"
    exit 1
fi

# Get token from CLN
CLN_REGISTER=$(curl -i -X POST -H "Content-Type: application/json" -H "accept: */*" -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" "$CLN_SERVER")
CLN_CODE=$(head -n1 <<< "$CLN_REGISTER")

# Check for successful response (HTTP 200)
if [[ ! "$CLN_CODE" == *"200"* ]]; then
    echo "Received incorrect status from CLN: $CLN_REGISTER"
    exit 1
fi

# Extract the token from the response
TOKEN=$(echo "$CLN_REGISTER" | grep -oP '"token":"\K[\w\d-]*')

# Validate if the token was found
if [[ -z $TOKEN ]]; then
    echo "Something went wrong. Token not defined."
    exit 1
fi

# Print the token
echo "Your registration token is: $TOKEN"
echo ""

# Print the repository URLs with the token
echo "You have successfully registered your Artifactory Server for OEL 7."
echo "Here are the URLs you may need depending on your system's architecture:"
echo ""
echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/"
echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/x86_64/"
echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/i686/"
echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/Sources"
