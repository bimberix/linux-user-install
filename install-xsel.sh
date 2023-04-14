#!/usr/bin/env bash
# sudo yum install -y automake autoconf git libtool

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" || exit 1

if [ ! -d xsel-1.2.0 ]
then
    curl -OL http://www.vergenet.net/~conrad/software/xsel/download/xsel-1.2.0.tar.gz
    tar -xzf xsel-1.2.0.tar.gz
fi

cd xsel-1.2.0 || exit 2

./autogen.sh
./configure --prefix="${HOME}/.local"
make install

