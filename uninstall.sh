#!/bin/bash

# Remove main script from /usr/local/bin/
sudo rm /usr/local/bin/claude-sandbox

# Remove the folder contining the docker file
sudo rm -r /usr/local/lib/claude-sandbox

# Remove claude-sandbox config folder
rm -r ~/.config/claude-sandbox

# Remove sandbox docker image
docker image rm claude-sandbox:latest
