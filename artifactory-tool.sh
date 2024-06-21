#!/bin/bash

# URL of the encrypted executable (raw URL)
URL="https://github.com/JCharleston-CLN/ELS-Tools/raw/main/artifactory-tool.sh.x"

# Download the encrypted executable
wget $URL -O artifactory-tool.sh.x

# Set execute permission
chmod +x artifactory-tool.sh.x

# Execute the script
./artifactory-tool.sh.x
