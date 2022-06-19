#!/bin/bash

set -e
set -u

src_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

apt update -y

apt upgrade -y

apt-get install build-essential -y

# source "$src_dir/scripts/installnim.sh"

#install_nim_check "1.6.6"
#nim -v
#nim c -r -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed mainapp
./mainapp