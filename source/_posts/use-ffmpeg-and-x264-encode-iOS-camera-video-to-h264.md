title: 利用FFmpeg+x264将iOS摄像头实时视频流编码为h264文件
date: 2015-09-18 09:43:27
tags:
- 音视频处理
- iOS中高级开发
---
### 一、编译x264库
如何编译x264源码获取支持iOS平台的静态库，可参考我的文章[《编译iOS平台上使用的X264库》](http://depthlove.github.io/2015/09/16/build-X264-library-for-iOS-platform/)

### 二、编译FFmpeg库
如何编译FFmpeg源码获取支持iOS平台的静态库，可参考我的博客园上的文章[《实战FFmpeg－－编译iOS平台使用的FFmpeg库（支持arm64的FFmpeg2.6.2）》](http://www.cnblogs.com/sunminmin/p/4463741.html#3195954)

### 三、将x264库编译进FFmpeg库
通过步骤二，知道了如何编译FFmpeg库，但是要在FFmpeg中使用x264进行h264编码，还需要修改步骤二中的脚本。

步骤二中，使用的脚本的下载地址为：[build-ffmpeg.sh](https://github.com/kewlbear/FFmpeg-iOS-build-script)

现在，FFmpeg的最新版本是 2.8，iOS系统的最新版本是 iOS 9.0.2，Xcode 最新版本是 Xcode 7.0.1，从 Xcode 7.0 开始支持 bitcode 选项了，bitcode 是什么，在百度上搜一搜就知道了。

<!-- more -->

看一看从下载地址获取的脚本，脚本内容如下：

```
#!/bin/sh

# directories
SOURCE="ffmpeg-2.8"
FAT="FFmpeg-iOS"

SCRATCH="scratch"
# must be an absolute path
THIN=`pwd`/"thin"

# absolute path to x264 library
#X264=`pwd`/fat-x264

#FDK_AAC=`pwd`/fdk-aac/fdk-aac-ios

CONFIGURE_FLAGS="--enable-cross-compile --disable-debug --disable-programs \
                 --disable-doc --enable-pic"

if [ "$X264" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-gpl --enable-libx264"
fi

if [ "$FDK_AAC" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-libfdk-aac"
fi

# avresample
#CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-avresample"

ARCHS="arm64 armv7 x86_64 i386"

COMPILE="y"
LIPO="y"

DEPLOYMENT_TARGET="6.0"

if [ "$*" ]
then
	if [ "$*" = "lipo" ]
	then
		# skip compile
		COMPILE=
	else
		ARCHS="$*"
		if [ $# -eq 1 ]
		then
			# skip lipo
			LIPO=
		fi
	fi
fi

if [ "$COMPILE" ]
then
	if [ ! `which yasm` ]
	then
		echo 'Yasm not found'
		if [ ! `which brew` ]
		then
			echo 'Homebrew not found. Trying to install...'
                        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
				|| exit 1
		fi
		echo 'Trying to install Yasm...'
		brew install yasm || exit 1
	fi
	if [ ! `which gas-preprocessor.pl` ]
	then
		echo 'gas-preprocessor.pl not found. Trying to install...'
		(curl -L https://github.com/libav/gas-preprocessor/raw/master/gas-preprocessor.pl \
			-o /usr/local/bin/gas-preprocessor.pl \
			&& chmod +x /usr/local/bin/gas-preprocessor.pl) \
			|| exit 1
	fi

	if [ ! -r $SOURCE ]
	then
		echo 'FFmpeg source not found. Trying to download...'
		curl http://www.ffmpeg.org/releases/$SOURCE.tar.bz2 | tar xj \
			|| exit 1
	fi

	CWD=`pwd`
	for ARCH in $ARCHS
	do
		echo "building $ARCH..."
		mkdir -p "$SCRATCH/$ARCH"
		cd "$SCRATCH/$ARCH"

		CFLAGS="-arch $ARCH"
		if [ "$ARCH" = "i386" -o "$ARCH" = "x86_64" ]
		then
		    PLATFORM="iPhoneSimulator"
		    CFLAGS="$CFLAGS -mios-simulator-version-min=$DEPLOYMENT_TARGET"
		else
		    PLATFORM="iPhoneOS"
		    CFLAGS="$CFLAGS -mios-version-min=$DEPLOYMENT_TARGET -fembed-bitcode"
		    if [ "$ARCH" = "arm64" ]
		    then
		        EXPORT="GASPP_FIX_XCODE5=1"
		    fi
		fi

		XCRUN_SDK=`echo $PLATFORM | tr '[:upper:]' '[:lower:]'`
		CC="xcrun -sdk $XCRUN_SDK clang"
		CXXFLAGS="$CFLAGS"
		LDFLAGS="$CFLAGS"
		if [ "$X264" ]
		then
			CFLAGS="$CFLAGS -I$X264/include"
			LDFLAGS="$LDFLAGS -L$X264/lib"
		fi
		if [ "$FDK_AAC" ]
		then
			CFLAGS="$CFLAGS -I$FDK_AAC/include"
			LDFLAGS="$LDFLAGS -L$FDK_AAC/lib"
		fi

		TMPDIR=${TMPDIR/%\/} $CWD/$SOURCE/configure \
		    --target-os=darwin \
		    --arch=$ARCH \
		    --cc="$CC" \
		    $CONFIGURE_FLAGS \
		    --extra-cflags="$CFLAGS" \
		    --extra-ldflags="$LDFLAGS" \
		    --prefix="$THIN/$ARCH" \
		|| exit 1

		make -j3 install $EXPORT || exit 1
		cd $CWD
	done
fi

if [ "$LIPO" ]
then
	echo "building fat binaries..."
	mkdir -p $FAT/lib
	set - $ARCHS
	CWD=`pwd`
	cd $THIN/$1/lib
	for LIB in *.a
	do
		cd $CWD
		echo lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB 1>&2
		lipo -create `find $THIN -name $LIB` -output $FAT/lib/$LIB || exit 1
	done

	cd $CWD
	cp -rf $THIN/$1/include $FAT
fi

echo Done

```

#### 三（一）、注意内容1

```
# absolute path to x264 library
#X264=`pwd`/fat-x264

#FDK_AAC=`pwd`/fdk-aac/fdk-aac-ios

CONFIGURE_FLAGS="--enable-cross-compile --disable-debug --disable-programs \
                 --disable-doc --enable-pic"

if [ "$X264" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-gpl --enable-libx264"
fi

if [ "$FDK_AAC" ]
then
	CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-libfdk-aac"
fi

# avresample
#CONFIGURE_FLAGS="$CONFIGURE_FLAGS --enable-avresample"
```

要将x264编译进FFmpeg中，需要取消对该句代码的注销 
	
	X264=`pwd`/fat-x264
	
即，
	
	#X264=`pwd`/fat-x264
	
改为

	X264=`pwd`/fat-x264
	
#### 三（二）、注意内容2
经过步骤三（一）的修改后，在Mac终端执行FFmpeg，脚本的时候，可能会存在因为bitcode引起编译出错。

需要将脚本中

```
CFLAGS="$CFLAGS -mios-version-min=$DEPLOYMENT_TARGET -fembed-bitcode"
```

修改为

```
CFLAGS="$CFLAGS -mios-version-min=$DEPLOYMENT_TARGET"
```

### 四、总结编译x264以及支持x264的FFmpeg的步骤

1. 编译得到 x264 静态库
2. 将存放x264静态库（头文件，库文件）的文件夹名称改为 fat-x264 （因为编译FFmpeg的脚本中定义存放x264文件的文件夹名称为fat-x264，看步骤三（一）中的内容）
3. 修改编译FFmpeg的脚本build-ffmpeg.sh，具体见步骤 三（一），三（二）
4. 将编译FFmpeg的脚本build-ffmpeg.sh 与 fat-x264 存放到同一个目录下
5. 在Mac终端执行脚本build-ffmpeg.sh
6. 最后x264静态库，支持x264的FFmpeg静态库，内容如下

![x264静态库](http://images2015.cnblogs.com/blog/719115/201510/719115-20151012182722241-1784823013.png)

![FFmpeg静态库](http://images2015.cnblogs.com/blog/719115/201510/719115-20151012182739491-661413965.png)

### 五、获取iOS设备摄像头实时视频

### 六，采用x264和FFmpeg对iOS实时视频流编码为h264

### 七、完整的代码下载地址

采用FFmpeg+x264将iOS摄像头实时视频流编码为h264文件的工程的下载地址为：[FFmpeg-X264-Encode-for-iOS
](https://github.com/depthlove/FFmpeg-X264-Encode-for-iOS)
	

	