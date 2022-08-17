#!/usr/bin/env bash
#
# Installs apt packages

# Setup

set -e

source "$HOME/.dotfiles/utils/logging_utils.sh"

echo ''

cd "$(dirname "$0")/.."
DOTFILES="$HOME/.dotfiles"

# Script Start

info 'Starting package install...'
sleep 1

# Install standard packages

function install_packages() {
	## Install dos2unix and use to fix any formatting issues
	if [ -f "${DOTFILES}/packages/packages.txt" ]; then
		success "Found Packages list. Installing..."
		if ! dpkg-query -W -f='${Status} ${Version}\n' dos2unix | grep "^install ok" >/dev/null; then
			info "Installing package dos2unix for formating "
			sudo apt -y install dos2unix
			dos2unix -q ${DOTFILES_LISTS}/packages.txt
			info "packages.txt file formatted"
		else
			dos2unix -q ${DOTFILES_LISTS}/packages.txt
			info "packages.txt file formatted"
		fi
	fi
	##	Looks for a list of default packages to install
	if [ -f "${DOTFILES}/packages/packages.txt" ]; then
		for i in $(cat ${DOTFILES}/packages/packages.txt); do
			if ! dpkg-query -W -f='${Status} ${Version}\n' ${i} | grep "^install ok" >/dev/null; then
				info "Installing package ${i} "
				sudo apt -y install ${i}
			else
				success "Package ${i} is already installed. Skipping..."
			fi
		done
	else
		fail "No Packages file found. Skipping package installation..."
	fi
}

# Install Dev Packages

function install_dev_packages() {
	## Install dos2unix and use to fix any formatting issues
	if [ -f "${DOTFILES}/packages/dev_packages.txt" ]; then
		success "Found Packages list. Installing..."
		if ! dpkg-query -W -f='${Status} ${Version}\n' dos2unix | grep "^install ok" >/dev/null; then
			info "Installing package dos2unix for formating "
			sudo apt -y install dos2unix
			dos2unix -q ${DOTFILES}/packages/dev_packages.txt
			info "dev_packages.txt file formatted"
		else
			dos2unix -q ${DOTFILES}/packages/dev_packages.txt
			info "dev_packages.txt file formatted"
		fi
	fi
	##	Looks for a list of default packages to install
	if [ -f "${DOTFILES_LISTS}/dev_packages.txt" ]; then
		for i in $(cat ${DOTFILES_LISTS}/dev_packages.txt); do
			if ! dpkg-query -W -f='${Status} ${Version}\n' ${i} | grep "^install ok" >/dev/null; then
				info "Installing package ${i} "
				sudo apt -y install ${i}
			else
				success "Package ${i} is already installed. Skipping..."
			fi
		done
	else
		fail "No Packages file found. Skipping package installation..."
	fi
}

user 'Do you want to install base packages? [y/n]'
read apt_answer
case "$apt_answer" in
y | Y | yes | Yes)
	info "Installing packages..."
	install_packages
  snap install bashtop
	;;
n | N | no | No)
	info "Skipping package installation"
	;;
*)
	fail "Please respond with yes or no"
	;;
esac
sleep 1

user 'Do you want to install dev packages? [y/n]'
read dev_apt_answer
case "$dev_apt_answer" in
y | Y | yes | Yes)
	success "Installing packages..."
	install_dev_packages
	;;
n | N | no | No)
	info "Skipping package installation"
	;;
*)
	fail "Please respond with yes or no"
	;;
esac
sleep 1