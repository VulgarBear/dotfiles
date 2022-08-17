#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# Run Installers
./docker/install.sh
./packages/install.sh
./node/install.sh
./system/install.sh