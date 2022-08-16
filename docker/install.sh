#!/usr/bin/env bash
#
# Installs docker.
# Setup

# Setup
set -e

echo ''

source "$HOME/.dotfiles/utils/logging_utils.sh"

#Script Start
info 'Installing docker...'

sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

echo ' '
info 'Verifying Pulling from Docker Repo...'
apt-cache policy docker-ce
sleep 3

sudo apt install docker-ce

echo ' '
info 'Verifying Docker is installed...'
sudo systemctl status docker
sleep 1

echo ' '
info 'Adding user to Docker group...'
sudo usermod -aG docker vulgarbear

echo ' '
success 'Docker install compelted...'
