#!/usr/bin/env bash
set -euo pipefail

if ! command -v x86_64-w64-mingw32-gcc >/dev/null ||
   ! command -v i686-w64-mingw32-gcc >/dev/null ||
   ! command -v x86_64-w64-mingw32-strip >/dev/null ||
   ! command -v i686-w64-mingw32-strip >/dev/null; then
  sudo apt-get update -qq
  sudo apt-get install -y --no-install-recommends \
    gcc-mingw-w64-x86-64 gcc-mingw-w64-i686 \
    binutils-mingw-w64-x86-64 binutils-mingw-w64-i686
fi

make -C BOF/Winver/SOURCE
test -s BOF/Winver/Winver.x64.o
test -s BOF/Winver/Winver.x86.o
