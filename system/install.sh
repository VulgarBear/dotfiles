#!/usr/bin/env bash
#
# Installs systems tools such as exa and etc.
# Setup

# Setup
set -e

echo ''

source "$HOME/.dotfiles/utils/logging_utils.sh"
DOTFILES="$HOME/.dotfiles"

#Script Start
read -e -p "
Do you wish to install system tools ? [Y/n] " YN

[[ $YN == "n" || $YN == "N" || $YN == "" ]] && exit

echo ''
info "Beginning system tool installations..."
sleep 1

# Prereqs
echo ''
info "Installing Prereqs..."
sleep 1
sudo apt install unzip -y

## Installing Rust Compiler
echo ''
info "Installing Prereqs: Rust Compiler"
user "When prompted select first option..."
sleep 1
curl https://sh.rustup.rs -sSf | sh

## Exa Install and config
info "Installing Exa..."
wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
unzip exa-linux-x86_64-0.8.0.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa
rm -rf exa-linux-x86_64-0.8.0.zip

#System Aliases
cat $DOTFILES/system/aliases >> ~/.bash_aliases
source ~/.bashrc

# Script End
echo ''
success "System Installation Completed..."
