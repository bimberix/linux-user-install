#!/usr/bin/env bash

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" || exit 1

scversion="stable" # or "v0.4.7", or "latest"
wget -qO- "https://github.com/koalaman/shellcheck/releases/download/${scversion?}/shellcheck-${scversion?}.linux.x86_64.tar.xz" | tar -xJv
cp "shellcheck-${scversion}/shellcheck" "${HOME}/.local/bin/"
