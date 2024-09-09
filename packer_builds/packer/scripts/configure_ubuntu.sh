#!/bin/bash
# Update and upgrade
sudo apt-get update && sudo apt-get upgrade -y

# Install common packages
sudo apt-get install -y build-essential curl git
