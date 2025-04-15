#! /bin/bash

set -xeuo pipefail

cmake_args=(
    ${CMAKE_ARGS}
    -GNinja
    -DCMAKE_MODULE_PATH=../cmake-modules
    -DBUILD_DOC=OFF
    -DPYTHON_BINDING=OFF
    -DSIMD_ARCH=GENERIC
    -DENABLE_TEST=OFF
)

if [ $(uname) = Darwin ] ; then
    cmake_args+=(
        -DCMAKE_CXX_FLAGS="$CXXFLAGS -stdlib=libc++"
        -DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOSX_DEPLOYMENT_TARGET
        -DCMAKE_OSX_SYSROOT=/
    )
fi

mkdir condabuild
cd condabuild
cmake "${cmake_args[@]}" ../libsakura
ninja -v -j$CPU_COUNT
ninja install
