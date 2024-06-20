### OSX 安装 ffmpeg

##### x86_64

- brew 安装 ffmpeg@6

```shell
alias ibrew='arch -x86_64 /usr/local/bin/brew'
ibrew install ffmpeg@6

头文件和库路径
# /usr/local/opt/ffmpeg@6/include
# /usr/local/opt/ffmpeg@6/lib
```

- 编译

```shell

# 动态库不要用相对路径
# 路径模仿 brew 安装的路径
./configure --enable-cross-compile --enable-shared \
     --prefix=/usr/local/opt/ffmpeg@6 --arch=x86_64 --cc='clang -arch x86_64'
```
