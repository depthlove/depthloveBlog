---
title: 在iOS上硬编码推流－摄像头数据采集（一）
date: 2016-03-17 15:55:53
tags:
- 音视频处理
- iOS
categories:
- 直播
---

该文的内容在我之前的文章中已经实现过，但是为了结构清晰起见，本文将相机控制和采集视频数据功能封装为单独的库。

iOS上使用AVFoundation.framework框架来调用系统相机并获取视频数据。视频数据可以根据设定的参数，可采集到RGB或YUV数据，一般使用的是GBRA32，420v，420f，下面演示相机的调用和视频数据的获取。

a)引入框架的头文件`#import <AVFoundation/AVFoundation.h>`

b)调用的类遵守协议`AVCaptureVideoDataOutputSampleBufferDelegate`

<!-- more -->

c)声明变量

	AVCaptureSession            *captureSession;
	AVCaptureDevice             *captureDevice;
	AVCaptureDeviceInput        *captureDeviceInput;
	AVCaptureVideoDataOutput    *captureVdieoDataOutput;

d)实现

e)demo地址 [https://github.com/depthlove/STMCamera](https://github.com/depthlove/STMCamera)






