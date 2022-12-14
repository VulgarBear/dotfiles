#!/usr/bin/env bash
#
# bootstrap installs things.

set -e

echo ''

source "$HOME/.dotfiles/utils/logging_utils.sh"

# Script Start
read -e -p "
Do you wish to install Node/NVM ? [Y/n] " YN

[[ $YN == "n" || $YN == "N" || $YN == "" ]] && exit

info 'Node Version Manager Installation'
sleep 1

function install_node() {

	##	Starts off by installing NVM [https://github.com/nvm-sh/nvm] which allows for multiple NodeJS
	##	versions to be installed. It also looks for a list of default packages to be installed with
	##	every Node version, and modifies the ~/.bashrc file to load NVM and Bash_Completion.

	echo >>~/.bashrc
	echo "# Set up NVM" >>~/.bashrc
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                 # This loads nvm
	[[ -r $NVM_DIR/bash_completion ]] && \. $NVM_DIR/bash_completion # This loads nvm bash_completion

	##	Check for a default packages list to install with every project
	if [ -f ${DOTFILES_CONFIG}/.nvm/default_packages ]; then
		cp ${DOTFILES_CONFIG}/.nvm/default_packages ~/.nvm/default-packages
	fi

	nvm install --lts
	nvm use --lts
}

if [ -d "$NVM_DIR" ]; then
	success " NVM is already installed!"
fi
if [ ! -d "$NVM_DIR" ]; then
  info 'Installing Node Version Manager...'
  install_node
fi

echo ' '
info 'Installing Yarn'
sleep 1

source ~/.bashrc
npm i -g yarn

echo ' '
success 'NVM Installation and Node LTS Complete...'