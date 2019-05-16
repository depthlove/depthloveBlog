---
title: iOS上使用VideoToolBox硬解码h264
date: 2015-10-24 15:55:12
tags:
- iOS
- 音视频处理
categories:
- 直播
---

以下内容摘自我博客的[编译iOS平台上使用的X264库](https://depthlove.github.io/2015/09/16/build-X264-library-for-iOS-platform/)一文。

从iOS8开始，苹果开放了硬解码和硬编码API，框架为VideoToolbox.framework， 此框架需要在iOS8及以上的系统上才能使用。

此框架中的硬解码API是几个纯C函数，在任何OC或者 C++代码里都可以使用。使用的时候，首先，要把 VideoToolbox.framework 添加到工程里，并且在要使用该API的文件中包含头文件 #include <VideoToolbox/VideoToolbox.h>，然后，就可以畅快的高效的对视频流进行硬编码了。

其实至少从iPhone4开始，苹果就是支持硬件解码了，但是硬解码API框架VideoToolBox一直是私有API，如果调用这个私有库，那么app在必须在越狱的设备上运行，正常的App如果想提交到AppStore是不允许使用私有API的。

<!-- more -->

点评：对于如何使用iOS平台上的VideoToolbox框架对图像数据进行硬编码，github上已经有很多demo了，虽然苹果官方文档对VideoToolbox介绍的不全面，但足以搞清楚整个流程，至于细节需要花些时间自己去搞了，比如时间戳的计算。