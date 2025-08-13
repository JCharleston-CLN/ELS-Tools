#!/usr/bin/env bash

clear
echo "****************************************************************************"
echo  "Title: TuxCare ELS Artifactory Registration Script."
echo  "Purpose: Register Artifactory Tool to TuxCare and provide URLs"
echo "         for Artifactory Configuration."
echo  "Created by: Jamie Charleston" 
echo  "Version: 2.2"
echo  "Last updated: 06/13/2025"
echo ""
echo  "Terms: By using this script to register your server, you agree that all"
echo  "       servers connecting to your Artifactory have been counted and that count"
echo  "       has been provided to your TuxCare Account Manager. If that number changes"
echo  "       as it pertains to your specific contract, you agree to provide updates to"
echo  "       your account manager. By continuing forward with using this tool and"
echo  "       registering your Artifactory, you agree to be bound by the TuxCare EULA"
echo  "       (https://tuxcare.com/legal/) or customized MSSA."
echo  ""
echo  "Disclaimer:"
echo  "This script is provided \"AS IS\" and without warranty of any kind."
echo  "You, the user, assume any risks associated with the use of this script."
echo  "You are solely responsible for the use and misuse of this script."
echo  "You agree to indemnify and hold harmless the creator of this script"
echo  "from any and all claims arising from your use or misuse of the script."
echo "****************************************************************************"

# Prompt the user to agree to the terms
read -p "Do you agree to these terms? (y/n): " response

if [[ "$response" != "y" ]]; then
  echo "You did not agree to the terms. Exiting script."
  exit 1
fi

echo "Thank you for agreeing to the TOS. Please continue."

# Prompt user for license key
read -p "Enter your license key: " LICENSE

# Ensure the license key is not empty
if [[ -z "$LICENSE" ]]; then
    echo "License key cannot be empty!"
    exit 1
fi

# Ask the user which distribution they are registering
echo ""
echo "Please select the operating system you are registering for:"
echo "1) Oracle Linux 6 (OEL 6)"
echo "2) Oracle Linux 7 (OEL 7)"
echo "3) CentOS 6, CentOS 6 SLA"
echo "4) CentOS 7 Standard, CentOS 7 Complete"
echo "5) CentOS 8.4"
echo "6) CentOS 8.5"
echo "7) CentOS 8 Stream"
echo "8) Ubuntu 16.04"
echo "9) Ubuntu 18.04"
echo "10) Ubuntu 20.04"
echo "11) AlmaLinux ESU / FIPS"
echo "12) PHP ELS for Linux"
echo "13) RockyLinux 9.6 Essential Support"
echo "14) RockyLinux 9.6 ESU"
echo "15) RHEL 7 ELS"
read -p "Enter the number corresponding to your OS: " OS_SELECTION

# Define API endpoints
CLN_SERVER_ESU="https://cln.cloudlinux.com/cln/api/els/token/register"
CLN_SERVER_CENTOS="https://cln.cloudlinux.com/cln/api/centos/token/register"
CLN_SERVER_OEL="https://cln.cloudlinux.com/cln/api/els/server/register"
HOSTNAME=$(hostname)

# Determine the correct API endpoint based on user selection
case "$OS_SELECTION" in
    1|2|12) CLN_SERVER="$CLN_SERVER_OEL" ;; # OEL 6 & 7
    3|4|5|6|7|8|9|10) CLN_SERVER="$CLN_SERVER_CENTOS" ;; # CentOS 6, 7, 8, 8 Stream, Ubuntu 16.04, Ubuntu 18.04
    11|13|14|15) CLN_SERVER="$CLN_SERVER_ESU" ;; # AlmaLinux ESU/FIPS, Rocky, RHEL 7
    *) 
        echo "Invalid selection. Please restart the script and choose a valid option."
        exit 1
    ;;
esac

# Get the registration token
CLN_REGISTER=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "accept: */*" \
    -d "{\"key\": \"$LICENSE\", \"host_name\": \"$HOSTNAME\"}" "$CLN_SERVER")

TOKEN=$(echo "$CLN_REGISTER" | grep -oP '"token":"\K[\w\d-]*')

# Validate if the token was found
if [[ -z "$TOKEN" ]]; then
    echo "Something went wrong. Token not defined."
    exit 1
fi

# Generate the correct repository URLs based on OS selection
echo ""
case "$OS_SELECTION" in
    1)  # OEL 6
        echo "Successfully registered your Artifactory Server for Oracle Linux 6."
        echo "Here are the URLs you need:"
        echo "https://repo.cloudlinux.com/oraclelinux6-els/${TOKEN}/updates/"
        echo "https://repo.cloudlinux.com/oraclelinux6-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.cloudlinux.com/oraclelinux6-els/${TOKEN}/updates/i686/"
        echo "https://repo.cloudlinux.com/oraclelinux6-els/${TOKEN}/updates/SRPMS/"
        ;;
    2)  # OEL 7
        echo "Successfully registered your Artifactory Server for Oracle Linux 7."
        echo "Here are the URLs you need:"
        echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/"
        echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/i686/"
        echo "https://repo.tuxcare.com/oraclelinux7-els/${TOKEN}/updates/Sources/"
        ;;
    3)  # CentOS 6 / CentOS 6 with SLA
        echo "Successfully registered your Artifactory Server for CentOS 6."
        echo "Here are the URLs you need:"
        echo "https://repo.cloudlinux.com/centos6-els//${TOKEN}/updates/"
        echo "https://repo.cloudlinux.com/centos6-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.cloudlinux.com/centos6-els/${TOKEN}/updates/i686/"
        echo "https://repo.cloudlinux.com/centos6-els/${TOKEN}/updates/SRPMS/"
        echo "https://repo.cloudlinux.com/centos6-els/${TOKEN}/updates/i386/"
        ;;
    4)  # CentOS 7 / CentOS 7 Complete
        echo "Successfully registered your Artifactory Server for CentOS 7."
        echo "Here are the URLs you need:"
        echo "https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/"
        echo "https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/i686/"
        echo "https://repo.tuxcare.com/centos7-els/${TOKEN}/updates/i386/"
        ;;
    5)  # CentOS 8.4  
        echo "Your have succesully registered your Artifactory Server for CentOS 8.4-els:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo "https://repo.cloudlinux.com/centos8.4-els/${TOKEN}/updates/"
        echo "https://repo.cloudlinux.com/centos8.4-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.cloudlinux.com/centos8.4-els/${TOKEN}/updates/i686/"
        echo "https://repo.cloudlinux.com/centos8.4-els/${TOKEN}/updates/Sources/"
        ;;
    6)  #CentOS 8.5          
        echo "Your have succesully registered your Artifactory Server for CentOS 8.5-els:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo "https://repo.cloudlinux.com/centos8.5-els/${TOKEN}/updates/"
        echo "https://repo.cloudlinux.com/centos8.5-els/${TOKEN}/updates/x86_64/"
        echo "https://repo.cloudlinux.com/centos8.5-els/${TOKEN}/updates/i686/"
        echo "https://repo.cloudlinux.com/centos8.5-els/${TOKEN}/updates/Sources/"
        ;;      
    7)  # CentOS 8 Stream
        echo "Your have succesully registered your Artifactory Server for CentOS 8 Stream:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo "https://repo.tuxcare.com/centos8stream-els/${TOKEN}/updates/i686/"
        echo "https://repo.tuxcare.com/centos8stream-els/${TOKEN}/updates/Sources/"
        echo "https://repo.tuxcare.com/centos8stream-els/${TOKEN}/updates/x86_64/"
        ;;
    8)  # Ubuntu 16.04 
        echo "Successfully registered your Artifactory Server for Ubuntu."
        echo "Here is the URL you need:"
        echo "https://repo.cloudlinux.com/ubuntu16_04-els/${TOKEN}/updates/"
        ;;
    9)  # Ubuntu 18.04
        echo "Successfully registered your Artifactory Server for Ubuntu."
        echo "Here is the URL you need:"
        echo "https://repo.cloudlinux.com/ubuntu18_04-els/${TOKEN}/updates/"
        ;;
    10)  # Ubuntu 20.04
        echo "Successfully registered your Artifactory Server for Ubuntu."
        echo "Here is the URL you need:"
        echo "https://repo.tuxcare.com/ubuntu20_04-els/${TOKEN}/updates/"
        ;;
        
    11)  # AlmaLinux ESU/FIPS
        echo "Your have succesully registered your Artifactory Server for AlmaLinux ESU/FIPS:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo "Please understand you require both the Base and ESU branches are minimum."
        echo "You only need to add the FIPs branch if you are enabling FIPS mode. "
        echo ""
        echo "https://repo.tuxcare.com/tuxcare/9.2/base/x86_64/"
        echo "https://repo.tuxcare.com/tuxcare/9.2/${TOKEN}/esu/x86_64/"
        #echo https://repo.tuxcare.com/tuxcare/9.2/${TOKEN}/fips/x86_64/
        echo "https://repo.tuxcare.com/tuxcare/9.6/base/x86_64/"
        echo "https://repo.tuxcare.com/tuxcare/9.6/${TOKEN}/esu/x86_64/"
        ;;

    12)  # PHP ELS
        echo "Your have succesully registered your Artifactory Server for PHP ELS:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo ""
        echo "https://repo.els.tuxcare.com/php-els/${TOKEN}/" 
        echo "https://repo.els.tuxcare.com/php-els/${TOKEN}/el9/updates/x86_64/"
        echo "https://repo.els.tuxcare.com/php-els/${TOKEN}/ubuntu22.04/updates/"   
        ;;
    13)  # RockyLinux 9.6 Essential Support
        echo "Your have succesully registered your Artifactory Server for RockyLinux 9.6 Essential Support:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo ""
        echo "https://repo.tuxcare.com/rockylinux/9.6/${TOKEN}/" 
        ;;

    14)  # RockyLinux 9.6 ESU
        echo "Your have succesully registered your Artifactory Server for RockyLinux 9.6 ESU:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo ""
        echo "https://repo.tuxcare.com/tuxcare/9.6/${TOKEN}/esu/" 

     15)  # RHEL 7 ELS
        echo "Your have succesully registered your Artifactory Server for RHEL 7:"
        echo "Here are the urls you may need depending on your systems architecture."
        echo ""
        echo ""
        echo "https://repo.tuxcare.com/rhel7-els/${TOKEN}/" 
esac

echo ""
echo "Please copy these URLs and save them in a safe place."


