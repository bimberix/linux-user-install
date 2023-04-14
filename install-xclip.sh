#!/usr/bin/env bash
# sudo yum install -y automake autoconf git libXmu libXmu-devel libtool

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" || exit 1

if [ -d xclip ]
then
    cd xclip
    git pull
else
    git clone https://github.com/astrand/xclip.git
    cd xclip
fi

autoreconf
./configure --prefix="${HOME}/.local"
make install
