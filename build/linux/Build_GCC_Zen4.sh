#!/bin/sh
# Auto-generated Linux multilib build script (8/10/12-bit) with jpsdr mod
# features enabled, mirroring build/MSYS_jpsdr/GCC_Zen4.sh.
#
# Requires: cmake, make, nasm (>=2.13), a C/C++ compiler; libvmaf-dev for
# ENABLE_LIBVMAF. AviSynth/VapourSynth are loaded via dlopen() at runtime,
# so no -dev package is needed to compile; .vpy support works on Linux if
# libvapoursynth-script.so is installed, .avs support requires an
# AviSynth-compatible shared library (AviSynth itself is Windows-only).
set -e

mkdir -p 8bit_gcc_zen4 10bit_gcc_zen4 12bit_gcc_zen4

cd 12bit_gcc_zen4
cmake ../../../source -DCMAKE_BUILD_TYPE=Release -DENABLE_LIBVMAF=ON -DENABLE_SCC_EXT=ON -DENABLE_MULTIVIEW=ON -DENABLE_ALPHA=ON -DENABLE_VAPOURSYNTH=ON -DENABLE_AVISYNTH=ON -DHIGH_BIT_DEPTH=ON -DENABLE_HDR10_PLUS=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DMAIN12=ON -DENABLE_LTO=ON -DCMAKE_CXX_FLAGS="-march=znver4" -DCMAKE_C_FLAGS="-march=znver4"
make ${MAKEFLAGS}
cp libx265.a ../8bit_gcc_zen4/libx265_main12.a

cd ../10bit_gcc_zen4
cmake ../../../source -DCMAKE_BUILD_TYPE=Release -DENABLE_LIBVMAF=ON -DENABLE_SCC_EXT=ON -DENABLE_MULTIVIEW=ON -DENABLE_ALPHA=ON -DENABLE_VAPOURSYNTH=ON -DENABLE_AVISYNTH=ON -DHIGH_BIT_DEPTH=ON -DENABLE_HDR10_PLUS=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DMAIN12=OFF -DENABLE_LTO=ON -DCMAKE_CXX_FLAGS="-march=znver4" -DCMAKE_C_FLAGS="-march=znver4"
make ${MAKEFLAGS}
cp libx265.a ../8bit_gcc_zen4/libx265_main10.a

cd ../8bit_gcc_zen4
cmake ../../../source -DCMAKE_BUILD_TYPE=Release -DENABLE_LIBVMAF=ON -DENABLE_SCC_EXT=ON -DENABLE_MULTIVIEW=ON -DENABLE_ALPHA=ON -DENABLE_VAPOURSYNTH=ON -DENABLE_AVISYNTH=ON -DHIGH_BIT_DEPTH=OFF -DENABLE_HDR10_PLUS=OFF -DEXPORT_C_API=ON -DENABLE_SHARED=OFF -DENABLE_CLI=ON -DMAIN12=OFF -DENABLE_LTO=ON -DLINKED_10BIT=ON -DLINKED_12BIT=ON -DEXTRA_LIB="x265_main10.a;x265_main12.a" -DEXTRA_LINK_FLAGS=-L. -DCMAKE_CXX_FLAGS="-march=znver4" -DCMAKE_C_FLAGS="-march=znver4"
make ${MAKEFLAGS}

# rename the 8bit library, then combine all three into libx265.a using GNU ar
mv libx265.a libx265_main.a

ar -M <<EOF
CREATE libx265.a
ADDLIB libx265_main.a
ADDLIB libx265_main10.a
ADDLIB libx265_main12.a
SAVE
END
EOF

# install the CLI, combined libx265.a, and headers (default prefix /usr/local)
sudo make install
