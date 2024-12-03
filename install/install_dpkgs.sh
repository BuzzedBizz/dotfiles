#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Install any system utilities/packages or global config
# Needed to get things up and running

set -e

# Install all dpkg-dependencies
echo "Updating apt"
sudo apt update
for src in $(find -H "$SCRIPT_DIR/.." -maxdepth 2 -name 'dpkg-dependencies.txt' -not -path '*.git*') ; do
    echo "Installing packages in ${src}"
    cat $src | xargs sudo apt install -y
done
