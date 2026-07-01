#!/bin/sh
# Auto-generated Linux build script: portable 8bit build plus a
# no-assembly 8bit build, for comparison/testing (mirrors the intent of
# build/MSYS_jpsdr/Clang_Generic.sh).
set -e

mkdir -p 8bit_clang_generic 8bit_clang_generic_noasm

cd 8bit_clang_generic
cmake ../../../source -DCMAKE_BUILD_TYPE=Release -DENABLE_LIBVMAF=ON -DENABLE_SCC_EXT=ON -DENABLE_MULTIVIEW=ON -DENABLE_ALPHA=ON -DENABLE_VAPOURSYNTH=ON -DENABLE_AVISYNTH=ON -DHIGH_BIT_DEPTH=OFF -DENABLE_HDR10_PLUS=OFF -DEXPORT_C_API=ON -DENABLE_SHARED=OFF -DENABLE_CLI=ON -DMAIN12=OFF -DENABLE_LTO=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
make ${MAKEFLAGS}

# install the assembly build (default prefix /usr/local); the noasm build
# below is for comparison/testing only and is intentionally not installed,
# so it doesn't silently overwrite this one
sudo make install

cd ../8bit_clang_generic_noasm
cmake ../../../source -DCMAKE_BUILD_TYPE=Release -DENABLE_LIBVMAF=ON -DENABLE_SCC_EXT=ON -DENABLE_MULTIVIEW=ON -DENABLE_ALPHA=ON -DENABLE_VAPOURSYNTH=ON -DENABLE_AVISYNTH=ON -DENABLE_ASSEMBLY=OFF -DHIGH_BIT_DEPTH=OFF -DENABLE_HDR10_PLUS=OFF -DEXPORT_C_API=ON -DENABLE_SHARED=OFF -DENABLE_CLI=ON -DMAIN12=OFF -DENABLE_LTO=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
make ${MAKEFLAGS}
