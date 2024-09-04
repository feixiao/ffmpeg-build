#!/bin/bash

# OSX
#NDK=$HOME/Library/Android/sdk/ndk/21.1.6352462
#TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64

echo $(pwd)
NDK=/home/frank/android/ndk/android-ndk-r20b
TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

OUT_DIR=$(pwd)/out/ffmpeg-6.1


cd ./ffmpeg-6.1
echo $(pwd)

ARCH=armv7a
CPU=armv7a
API=21
CC=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang
CXX=$TOOLCHAIN/bin/armv7a-linux-androideabi$API-clang++
SYSROOT=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-
PREFIX=$OUT_DIR/armv7a
OPTIMIZE_CFLAGS="-march=$CPU"

./configure \
	--prefix=$PREFIX --disable-postproc \
	--disable-debug --disable-doc \
	--disable-symver --disable-doc --disable-avdevice \
	--enable-gpl --enable-static  \
	--enable-neon --enable-hwaccels --enable-jni \
	--enable-small --enable-mediacodec \
	--cross-prefix=$CROSS_PREFIX --target-os=android \
	--arch=$ARCH --cpu=$CPU \
	--cc=$CC  --cxx=$CXX \
	--enable-cross-compile \
	--sysroot=$SYSROOT \
	--extra-cflags="-Os -fpic $OPTIMIZE_CFLAGS" \
	--extra-ldflags="-L $ADDI_LDFLAGS" \
	--pkg-config="pkg-config --static"


make clean
make -j 8
make install