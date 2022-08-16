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

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y

echo ' '
info 'Verifying Pulling from Docker Repo...'
apt-cache policy docker-ce
sleep 3

sudo apt install docker-ce -y

echo ' '
info 'Verifying Docker is installed...'
sudo systemctl status docker
sleep 1

echo ' '
info 'Installing Docker Compose'
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo ' '
info 'Adding user to Docker group...'
sudo usermod -aG docker vulgarbear

#Script End
echo ' '
success 'Docker install compelted...'
