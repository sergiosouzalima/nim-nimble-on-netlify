#!/bin/bash

set -e
set -u

src_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$src_dir/scripts/installnim.sh"

#install_nim_check "1.6.6"
curl https://nim-lang.org/choosenim/init.sh -ysSf | sh
nim -v
choosenim --version
nimble install xml -n
nim c -r -d:ssl --verbosity:0 --hints:off -d:danger -d:lto --opt:speed mainapp