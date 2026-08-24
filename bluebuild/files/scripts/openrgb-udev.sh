#!/usr/bin/env bash

set -oue pipefail

echo "Fetching openrgb udev rules"
wget -P /usr/lib/udev/rules.d \
    https://gitlab.com/CalcProgrammer1/OpenRGB/-/jobs/artifacts/master/raw/60-openrgb.rules?job=Linux+amd64+AppImage&inline=false

# This is the suggested link, but the release has magically disappeared
# https://openrgb.org/releases/release_0.9/60-openrgb.rules

