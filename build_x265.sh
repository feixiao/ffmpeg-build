#!/bin/bash
 
export NDK=/opt/ndk/android-ndk-r22
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export PATH=${PATH}:${NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin
export API=21

export OUT_DIR=$(pwd)/out/x265
export WORKSPACE=$(pwd)/x265_2.5/source/

cd ${WORKSPACE}


#APP_ABIs="arm64-v8a armeabi-v7a"
APP_ABIs="arm64-v8a"

mkdir android_build_${APP_ABI} && cd android_build_${APP_ABI}

cmake -DCMAKE_TOOLCHAIN_FILE=${NDK}/build/cmake/android.toolchain.cmake \
 -DANDROID_ABI=${APP_ABI} \
 -DCMAKE_INSTALL_PREFIX=${OUT_DIR} \
 -DANDROID_PLATFORM=android-21 \
 -DENABLE_SHARED=OFF  \
 -DCMAKE_SYSTEM_NAME=Android \
 -DCMAKE_BUILD_TYPE=RELEASE \
 -DENABLE_ASSEMBLY=OFF -DENABLE_CLI=OFF \
 -DTARGET_OS_NAME=Android \
 ../
make -j4
make install

rm -rf $WORKSPACE/android_build_${APP_ABI}
