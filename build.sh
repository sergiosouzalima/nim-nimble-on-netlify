#!/bin/bash

set -e
set -u

src_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$src_dir/scripts/installnim.sh"

install_nim_check "1.6.6"
nim -v
nim c -r "$src_dir/mainapp.nim"
