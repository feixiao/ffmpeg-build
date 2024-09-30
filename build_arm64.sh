#!/bin/bash

# OSX
#NDK=$HOME/Library/Android/sdk/ndk/21.1.6352462
#TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64

echo $(pwd)
NDK=/opt/ndk/android-ndk-r22
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

OUT_DIR=$(pwd)/out/ffmpeg-6.1


cd ./ffmpeg-6.1
echo $(pwd)

ARCH=arm64
CPU=armv8-a
API=21
CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
PREFIX=$OUT_DIR/arm64-v8a
#OPTIMIZE_CFLAGS="-march=$CPU"

./configure \
	--enable-pic \
	--prefix=$PREFIX --disable-postproc \
	--disable-debug --disable-doc \
	--disable-symver --disable-doc --disable-avdevice \
	--enable-gpl --enable-static  --enable-shared \
    --enable-hwaccels --enable-jni \
	--disable-asm --disable-neon \
	--enable-small --enable-mediacodec \
	--cross-prefix=$CROSS_PREFIX --target-os=android \
	--arch=$ARCH --cpu=$CPU \
	--cc=$CC  --cxx=$CXX \
	--enable-cross-compile \
	--sysroot=$SYSROOT \
	--extra-cflags="-Os -fPIC $OPTIMIZE_CFLAGS" \
	--extra-ldflags="-L $ADDI_LDFLAGS" \
	--disable-debug \
    --disable-doc \
    --disable-ffmpeg \
    --disable-ffplay \
    --disable-ffprobe \
    --disable-symver 

make clean
make -j 8
make install