#!/bin/bash

# Define a function to generate URLs based on the token and product type
generate_urls() {
    local token=$1
    local prefix=$2

    # Output the prefix for debugging
    echo "Detected prefix: $prefix"
    
    # Determine URLs based on license key prefix
    case "$prefix" in
        CELS)         # CentOS 6
            echo "URLs using token $token for CentOS 6:"
            echo "1. https://repo.cloudlinux.com/centos6-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/centos6-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/centos6-els/${token}/updates/i386/"
            echo "4. https://repo.cloudlinux.com/centos6-els/${token}/updates/SRPMS/"
            echo "5. https://repo.cloudlinux.com/centos6-els/${token}/updates/"            
            ;;
        CELS_8)       # CentOS 8
            echo "URLs using token $token for CentOS 8.5-els:"
            echo "1. https://repo.cloudlinux.com/centos8.5-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/centos8.5-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/centos8.5-els/${token}/updates/Sources/"
            echo "URLs using token $token for CentOS 8.4-els:"
            echo "1. https://repo.cloudlinux.com/centos8.4-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/centos8.4-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/centos8.4-els/${token}/updates/Sources/"
            ;;
        UELS16)         # Ubuntu 16.04
            echo "URLs using token $token for Ubuntu 16.04:"
            echo "1. https://repo.cloudlinux.com/ubuntu16_04-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/ubuntu16_04-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/ubuntu16_04-els/${token}/updates/i386/"
            ;;
        CENTOS7)      # CentOS 7 Standard
            echo "URLs using token $token for CentOS 7 Standard:"
            echo "1. https://repo.tuxcare.com/centos7-els/${token}/updates/x86_64/"
            echo "2. https://repo.tuxcare.com/centos7-els/${token}/updates/i686/"
            echo "3. https://repo.tuxcare.com/centos7-els/${token}/updates/i386/"
            ;;
        CENTOS7COMP)  # CentOS 7 Complete
            echo "URLs using token $token for CentOS 7 Complete:"
            echo "1. https://repo.tuxcare.com/centos7-els/${token}/updates/x86_64/"
            echo "2. https://repo.tuxcare.com/centos7-els/${token}/updates/i686/"
            echo "3. https://repo.tuxcare.com/centos7-els/${Ttoken}/updates/i386/"
            ;;
        CENTOS8STREAM)# CentOS 8 Stream
            echo "URLs using token $token for CentOS 8 Stream:"
            echo "1. comming soon"
            echo "2. comming soon"
            echo "3. comming soon"
            ;;
        OELS)         # OEL 6
            echo "URLs using token $token for OEL 6:"
            echo "1. https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/SRPMS/"
            ;;
        UELS18)       # Ubuntu 18.04
            echo "URLs using token $token for Ubuntu 18.04:"
            echo "1. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/i386/"
            ;;
        UELS18SLA)    # Ubuntu 18.04 SLA
            echo "URLs using token $token for Ubuntu 18.04 SLA:"
            echo "1. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/x86_64/"
            echo "2. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/i686/"
            echo "3. https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/i386/"
            ;;
    esac
    echo "The script is complete."

}

# Prompt user for license key
echo "Please enter your license key:"
read LICENSE

# Extract the prefix by finding the first part of the license key before the dash
PREFIX=$(echo "$LICENSE" | grep -oE '^[^-]*')

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
    echo "Token retrieved successfully."
    echo "$TOKEN" 
    echo "$PREFIX"
    generate_urls "$TOKEN" "$PREFIX"
fi
