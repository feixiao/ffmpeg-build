FFmpeg6.0 下载：https://ffmpeg.org/releases/ffmpeg-6.0.tar.xz

x264 下载：https://www.videolan.org/developers/x264.html

```
.
├── build_ffmpeg.sh
├── build_x264.sh
├── ffmpeg-6.0
├── x264
└── 下载.md
```

下载后保持如此目录

- 先使用 build_x264.sh 编译 x264

```shell
./build_x264.sh
```

- 再使用 build_ffmpeg.sh 编译 ffmpeg

```shell
export NDK=${HOME}/Library/Android/sdk/ndk/21.4.7075529
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
export OUT_DIR=$(pwd)/out/ffmpeg-6.0

export ARCH=arm64
export CPU=armv8-a
export API=21
export CC=$TOOLCHAIN/bin/aarch64-linux-android$API-clang
export CXX=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++
export SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot
export CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-
export PREFIX=$OUT_DIR/arm64-v8a
export OPTIMIZE_CFLAGS="-march=$CPU"


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
```
