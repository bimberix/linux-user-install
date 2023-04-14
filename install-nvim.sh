#!/usr/bin/env bash

set -e

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

if [ -d nvim ]
then
    cd neovim
    git pull
else
    git clone https://github.com/neovim/neovim.git -b stable
    cd neovim
fi

make CMAKE_BUILD_TYPE="Release" CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${HOME}/.local"
make install
