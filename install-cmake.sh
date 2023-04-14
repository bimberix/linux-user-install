#!/usr/bin/env bash

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" || exit 1

CMAKE_VERSION=3.25.2

wget "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz"
tar xvf cmake-${CMAKE_VERSION}.tar.gz -C .
cd "cmake-${CMAKE_VERSION}" || exit 1
./bootstrap -- -DCMAKE_INSTALL_PREFIX="${HOME}/.local"
make install
