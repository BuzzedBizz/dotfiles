#!/usr/bin/env bash

set -oue pipefail

echo "Fetching openrgb udev rules"
wget -P /usr/lib/udev/rules.d \
    https://openrgb.org/releases/release_0.9/60-openrgb.rules

