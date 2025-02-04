#!/bin/bash
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


# Define a function to generate URLs based on the token and product type
generate_urls() {
    local token=$1
    local prefix=$2

    # Output the prefix for debugging
    # echo "Detected prefix: $prefix"
    
    # Determine URLs based on license key prefix
    case "$prefix" in
        CELS)         # CentOS 6
            echo "Your have succesully registered your Artifactory Server for CentOS 6:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/x86_64/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/i686/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/i386/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/SRPMS/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/"            
            ;;
        ELS_FOR_CENTOS6_PLUS_SLA)         # CentOS 6
            echo "Your have succesully registered your Artifactory Server for CentOS 6:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/x86_64/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/i686/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/i386/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/SRPMS/"
            echo "https://repo.cloudlinux.com/centos6-els/${token}/updates/"            
            ;;    
        CENTOS7)      # CentOS 7 Standard
            echo "Your have succesully registered your Artifactory Server for CentOS 7 Standard:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/"
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/x86_64/"
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/i686/"
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/i386/"
            ;;
        CENTOS7COMP)  # CentOS 7 Complete
            echo "Your have succesully registered your Artifactory Server for CentOS 7 Complete:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/"
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/x86_64/"
            echo "https://repo.tuxcare.com/centos7-els/${token}/updates/i686/"
            echo "https://repo.tuxcare.com/centos7-els/${Ttoken}/updates/i386/"
            ;;
        CELS_8)       # CentOS 8
            echo "Your have succesully registered your Artifactory Server for CentOS 8.5-els:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.cloudlinux.com/centos8.5-els/${token}/updates/"
            echo "https://repo.cloudlinux.com/centos8.5-els/${token}/updates/x86_64/"
            echo "https://repo.cloudlinux.com/centos8.5-els/${token}/updates/i686/"
            echo "https://repo.cloudlinux.com/centos8.5-els/${token}/updates/Sources/"
            echo ""
            echo "Your have succesully registered your Artifactory Server for CentOS 8.4-els:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.cloudlinux.com/centos8.4-els/${token}/updates/"
            echo "https://repo.cloudlinux.com/centos8.4-els/${token}/updates/x86_64/"
            echo "https://repo.cloudlinux.com/centos8.4-els/${token}/updates/i686/"
            echo "https://repo.cloudlinux.com/centos8.4-els/${token}/updates/Sources/"
            ;;    
        CENTOS8STREAM)# CentOS 8 Stream
            echo "Your have succesully registered your Artifactory Server for CentOS 8 Stream:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.tuxcare.com/centos8stream-els/${token}/updates/i686/"
            echo "https://repo.tuxcare.com/centos8stream-els/${token}/updates/Sources/"
            echo "https://repo.tuxcare.com/centos8stream-els/${token}/updates/x86_64/"
            ;;
        OELS)         # OEL 6
            echo "Your have succesully registered your Artifactory Server for OEL 6:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/"
            echo "https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/x86_64/"
            echo "https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/i686/"
            echo "https://repo.cloudlinux.com/oraclelinux6-els/${token}/updates/SRPMS/"
            ;;
        OLINUX7)         # OEL 7
            echo "Your have succesully registered your Artifactory Server for OEL 7:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "https://repo.tuxcare.com/oraclelinux7-els/${token}/updates/"
            echo "https://repo.tuxcare.com/oraclelinux7-els/${token}/updates/x86_64/"
            echo "https://repo.tuxcare.com/oraclelinux7-els/${token}/updates/i686/"
            echo "https://repo.tuxcare.com/oraclelinux7-els/${token}/updates/Sources"
            ;;    
        UELS16)         # Ubuntu 16.04
            echo "Your have succesully registered your Artifactory Server for Ubuntu 16.04:"
            echo "Here is the url you need for your Artifactory configuration."
            echo ""
            echo "https://repo.cloudlinux.com/ubuntu16_04-els/${token}/updates/"
            ;;
        UELS18)       # Ubuntu 18.04
            echo "Your have succesully registered your Artifactory Server for Ubuntu 18.04:"
            echo "Here is the url you need for your Artifactory configuration."
            echo ""
            echo "https://repo.cloudlinux.com/ubuntu18_04-els/${token}/updates/"
            ;;
         ESU) # AlmaLinux ESU / FIPS
            echo "Your have succesully registered your Artifactory Server for AlmaLinux ESU/FIPS:"
            echo "Here are the urls you may need depending on your systems architecture."
            echo ""
            echo "Please understand you require both the Base and ESU branches are minimum."
            echo "You only need to add the FIPs branch if you are enabling FIPS mode. "
            echo ""
            echo https://repo.tuxcare.com/tuxcare/9.2/base/x86_64/
            echo https://repo.tuxcare.com/tuxcare/9.2/${token}/esu/x86_64/
            echo https://repo.tuxcare.com/tuxcare/9.2/${token}/fips/x86_64/
            #echo  These are for Essential Support
            #echo https://repo.tuxcare.com/almalinux/9.2/${token}/AppStream/x86_64/os/
            #echo https://repo.tuxcare.com/almalinux/9.2/${token}/BaseOS/x86_64/os/
            #echo https://repo.tuxcare.com/almalinux/9.2/${token}/extras/x86_64/os/
            ;;        
         

    esac
    echo ""
    echo "Please copy these urls and save them in a safe space. These are specific to your "
    echo "organization and are your responsibility to protect. If you need GPG Keys please"
    echo "consult your Artifactory Deployment Guide, which provided you with these instructions."
    echo "If you have any questions please reach out to your Sales Team members." 

}

# Prompt user for license key
echo "Please enter your license key:"
read LICENSE

# Define the server URLs
CLN_SERVER_ESU="https://cln.cloudlinux.com/cln/api/els/token/register"
CLN_SERVER_CENTOS="https://cln.cloudlinux.com/cln/api/centos/token/register"
HOSTNAME=$(hostname)

# Extract the prefix by finding the first part of the license key before the dash
#PREFIX=$(echo "$LICENSE" | grep -oE '^[^-]*')
PREFIX=$(echo "$LICENSE" | grep -oE '^[A-Z_]+')

# Determine the appropriate curl command based on the prefix and retrieve the token
if [[ "$PREFIX" == "ESU" ]]; then
    # ESU prefix uses the ELS API
    TOKEN=$(curl -s -i -X POST \
                -H "Content-Type: application/json" \
                -H "accept: */*" \
                -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" \
                "$CLN_SERVER_ESU" | grep -oP '"token":"\K[\w\d-]*')

elif [[ "$PREFIX" == "OELS" || "$PREFIX" == "OLINUX7" ]]; then
    # OELS and OLINUX7 prefixes use the CLN API
    TOKEN=$(curl -i -X POST \
                -H "Content-Type: application/json" \
                -H "accept: */*" \
                -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" \
                "$CLN_SERVER")

else
    # Default case (for all other prefixes)
    TOKEN=$(curl -s -X POST \
                -H "Content-Type: application/json" \
                -H "Accept: */*" \
                -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" \
                "$CLN_SERVER_CENTOS" | grep -oP '"token":"\K[\w\d-]*')
fi

# Check if the token was successfully captured
if [ -z "$TOKEN" ]; then
    echo "Failed to retrieve token. Please check your license key and try again."
else
    echo ""
    generate_urls "$TOKEN" "$PREFIX"
fi
