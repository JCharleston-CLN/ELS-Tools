#!/bin/bash

# URL of the encrypted executable
URL="https://github.com/JCharleston-CLN/ELS-Tools/releases/tag/v1.0.0"

# Download the encrypted executable
wget $URL

# Set execute permission
chmod +x artifactory-tool.sh.x

# Execute the script
./artifactory-tool.sh.x
