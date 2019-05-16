---
title: 编译iOS平台上使用的X264库
date: 2015-09-16 15:56:46
tags: 
- 音视频处理
categories:
- 直播
---

x264是一种免费的、具有更优秀算法的符合H.264/MPEG-4 AVC视频压缩编码标准格式的编码库。它同xvid一样都是开源项目，但x264是采用H.264标准的，而xvid是采用MPEG-4早期标准的。由于H.264是2003年正式发布的最新的视频编码标准，因此，在通常情况下，x264压缩出的视频文件在相同质量下要比xvid压缩出的文件要小，或者也可以说，在相同体积下比xvid压缩出的文件质量要好。它符合GPL许可证。

从iOS8开始，苹果开放了硬解码和硬编码API，框架为 **VideoToolbox.framework**， 此框架需要在iOS8及以上的系统上才能使用。此框架中的硬解码API是几个纯C函数，在任何OC或者 C++代码里都可以使用。使用的时候，首先，要把 VideoToolbox.framework 添加到工程里，并且在要使用该API的文件中包含头文件 **#include &lt;VideoToolbox/VideoToolbox.h&gt;**，然后，就可以畅快的高效的对视频流进行硬编码了。

<!-- more -->

其实至少从iPhone4开始，苹果就是支持硬件解码了，但是硬解码API框架**VideoToolBox**一直是私有API，如果调用这个私有库，那么app在必须在越狱的设备上运行，正常的App如果想提交到AppStore是不允许使用私有API的。

此处，不讨论iOS硬编解码框架**VideoToolbox.framework**的使用。现在，使用较多的h264编码工具还是X264开源库。要想在iOS平台上使用X264编码视频流，首先要知道如何编译运行在iOS上的X264静态库。

编译X264的一个靠谱的脚本为[https://github.com/kewlbear/x264-ios](https://github.com/kewlbear/x264-ios)，但是，使用该脚本有个不方便的，就是要先下载X264并解压好，同时要下载[https://github.com/libav/gas-preprocessor](https://github.com/libav/gas-preprocessor)并将gas-preprocessor.pl拷贝到/usr/local/bin/下，并且赋予管理员权限，才能启动脚本进行编译。

为了使用脚本一步到位得到X264静态库，我在该脚本的基础上做了一些修改。

##### 第一处修改：

	# sunminmin blog: http://depthlove.github.io/
	# modified by sunminmin, 2015/09/07
	#ARCHS="arm64 armv7s x86_64 i386 armv7"
	ARCHS="arm64 x86_64 i386 armv7"
	
##### 第二处修改：

	# begin: added by sunminmin, 2015/09/07
    if [ ! -r $GAS_PREPROCESSOR ]
    then
    echo 'gas-preprocessor.pl not found. Trying to install...'
    (curl -L https://github.com/libav/gas-preprocessor/blob/master/gas-preprocessor.pl \
    -o /usr/local/bin/gas-preprocessor.pl \
    && chmod +x /usr/local/bin/gas-preprocessor.pl) \
    || exit 1
    fi


    if [ ! -r $SOURCE ]
    then
    echo 'x264 source not found. Trying to download...'
    curl https://download.videolan.org/pub/x264/snapshots/x264-snapshot-20140930-2245.tar.bz2 | tar xj && ln -s x264-snapshot-20140930-2245 x264 || exit 1
    fi
	# end: added by sunminmin, 2015/09/07
	
##### 第三处修改：

	# begin: added by sunminmin, 2015/09/07
	echo "copy config.h to ..."
	for ARCH in $ARCHS
	do
	cd $CWD
	echo "copy $SCRATCH/$ARCH/config.h to $THIN/$ARCH/$include"
	cp -rf $SCRATCH/$ARCH/config.h $THIN/$ARCH/$include || exit 1
	done

	echo "building success!"
	# end: added by sunminmin, 2015/09/07

**修改后的脚本下载地址：[https://github.com/depthlove/x264-iOS-build-script](https://github.com/depthlove/x264-iOS-build-script)**

**原始脚本下载地址：[https://github.com/kewlbear/x264-ios](https://github.com/kewlbear/x264-ios)**

后续文章后写如何使用x264库对iOS设备摄像头实时视频流进行h264软编码。