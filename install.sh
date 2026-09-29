#!/bin/bash

# Copy main script in /usr/local/bin
sudo cp claude-sandbox /usr/local/bin/
sudo chmod +x /usr/local/bin/claude-sandbox

# Copy Dockerfile in /usr/local/lib/claude-sandbox/
# This is not mandatory but allows the user to change the docker environemnt and rebuild the image
# When rebuilding the image use the name `claude-sandbox` which is the name the main srcipt uses to run the container
sudo mkdir -p /usr/local/lib/claude-sandbox/
sudo cp Dockerfile /usr/local/lib/claude-sandbox/
sudo cp entrypoint.sh /usr/local/lib/claude-sandbox/

# Create claude-sandbox configiratons folder with default environment
mkdir -p ~/.config/claude-sandbox/.claude

# Crate docker image
docker build -t claude-sandbox /usr/local/lib/claude-sandbox
