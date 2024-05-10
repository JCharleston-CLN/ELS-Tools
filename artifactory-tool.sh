#!/bin/bash

# Define a function to generate URLs based on product type
generate_urls() {
    local product=$1
    local token=$2

    echo "URLs for $product using token $token:"
    echo "1. https://repo.tuxcare.com/${product}/${token}/updates/x86_64/"
    echo "2. https://repo.tuxcare.com/${product}/${token}/updates/i686/"
    echo "3. https://repo.tuxcare.com/${product}/${token}/updates/i386/"
}

# Prompt user for license key
echo "Please enter your license key:"
read LICENSE

# Determine the product type based on the license key prefix
PRODUCT=""
case "$LICENSE" in
    CELS-*)         PRODUCT="centos6-els" ;;
    CELS_8-*)       PRODUCT="centos8-els" ;;
    UELS-*)         PRODUCT="ubuntu1604-els" ;;
    CENTOS7-*)      PRODUCT="centos7-els-standard" ;;
    CENTOS7COMP-*)  PRODUCT="centos7-els-complete" ;;
    CENTOS8STREAM-*)PRODUCT="centos8stream-els" ;;
    OELS-*)         PRODUCT="oel6-els" ;;
    UELS18-*)       PRODUCT="ubuntu1804-els" ;;
    UELS18SLA-*)    PRODUCT="ubuntu1804sla-els" ;;
    *)              echo "Invalid license key. Please check and try again."; exit 1 ;;
esac

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
    generate_urls "$PRODUCT" "$TOKEN"
fi

    echo "Token retrieved successfully."
    generate_urls "$PRODUCT" "$TOKEN"
fi
