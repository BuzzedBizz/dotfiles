#!/usr/bin/env bash

set -xe

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cp -RT "${SCRIPT_DIR}/config" ~/.config

