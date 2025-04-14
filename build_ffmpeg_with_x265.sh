#!/bin/bash

echo $(pwd)

export NDK=/opt/ndk/android-ndk-r22

export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export PATH=${PATH}:${NDK}/toolchains/llvm/prebuilt/linux-x86_64/bin
export API=21

export BASE_PATH=$(pwd)
export OUT_DIR=$(pwd)/out/ffmpeg-6.1
export PKG_CONFIG_PATH="$(pwd)/out/x265/lib/pkgconfig$PKG_CONFIG_PATH"


cd ./ffmpeg-6.1


export ARCH=arm64
export CPU=armv8-a
export CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
export SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
export CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
export PREFIX=$OUT_DIR/arm64-v8a
#OPTIMIZE_CFLAGS="-march=$CPU"

./configure \
	--enable-pic \
	--prefix=$PREFIX --disable-postproc \
    --enable-libx265 \
	--disable-debug --disable-doc \
	--disable-symver --disable-doc --disable-avdevice \
	--enable-gpl --enable-static  \
    --enable-hwaccels --enable-jni \
	--disable-asm --disable-neon \
	--enable-small --enable-mediacodec \
	--cross-prefix=$CROSS_PREFIX --target-os=android \
	--arch=$ARCH --cpu=$CPU \
	--cc=$CC  --cxx=$CXX \
	--enable-cross-compile \
	--sysroot=$SYSROOT \
	--extra-cflags="-I${BASE_PATH}/out/x265/include -Os -fPIC $OPTIMIZE_CFLAGS" \
	--extra-ldflags="-L${BASE_PATH}/out/x265/lib" \
	--disable-debug \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-symver 

#make clean
make -j 8
make install