---
title: WebRTC 开发（三）架构设计剖析
date: 2019-05-04 06:10:51
tags:
- WebRTC
- 音视频处理
categories:
- WebRTC
---

上一篇写的是 WebRTC 源码的下载和编译，为什么不先剖析 WebRTC 的架构设计而是先讲编译过程呢？原因是通过观察 WebRTC 的编译过程，能看到 WebRTC 里有什么。很多人觉得编译过程耗时长，就去干点其它的事坐等编译过程结束。我喜欢观察编译过程的打印信息，通过观察，可以看到 WebRTC 里面有什么，形成对 WebRTC 源码库有基本的认识。接触一个东西时，最初都是从局部到整体。知道 WebRTC 里面存在一些东西，但这些东西是如何组织在一起形成一个完整的解决方案的呢？那就要分析 WebRTC 的架构和设计了。

<!-- more -->

WebRTC 的整体架构图如下

![WebRTC 整体架构图](https://raw.githubusercontent.com/depthlove/depthloveBlog/8c991266c4350b1b66dc277d7576903824013017/source/images/webrtc-development-3-analysis-of-architectural-design/webrtc-architecture.png)


> # 一、音频模块

WebRTC 的音频部分，包含设备、编解码(Opus/iLIBC/iSAC/G722/PCM16/RED/AVT、NetEQ)、加密、声音文件、声音处理、声音输出、音量控制、音视频同步、网络传输与流控(RTP/RTCP)等功能。

## 音频设备 audio_device

源代码在 webrtc\modules\audio_device\main 目录下，包含接口和各个平台的源代码。

在 Windows 平台上，WebRTC 采用的是 Windows Core Audio 和 Windows Wave 技术来管理音频设备，还提供了一个混音管理器。

利用音频设备，可以实现声音输出，音量控制等功能。

## 声音文件 media_file

源代码在 webrtc\modules\media_file 目录下。

该功能是可以用本地文件作为音频源，支持的格式有 PCM 和 WAV。

同样，WebRTC 也可以录制音频到本地文件。

## 声音处理 audio_processing

源代码在 webrtc\modules\audio_processing 目录下。

声音处理针对音频数据进行处理，包括回声消除(AEC)、AECM(AEC Mobile)、自动增益(AGC)、降噪(NS)、静音检测(VAD)处理等功能，用来提升声音质量。

## 音频编解码 audio_coding

源代码在 webrtc\modules\audio_coding 目录下。

WebRTC 采用 Opus/iLIBC/iSAC/G722/PCM16/RED/AVT 编解码技术。

WebRTC 还提供 NetEQ 功能 --- 抖动缓冲器及丢包补偿模块，能够提高音质，并把延迟减至最小。

另外一个核心功能是基于语音会议的混音处理。

## 声音加密 voice_engine_encryption

和视频一样，WebRTC也提供声音加密功能。


> # 二、视频模块

## 视频采集 video_capture

源代码在 webrtc\modules\video_capture\main 目录下，包含接口和各个平台的源代码。

在 Windows 平台上，WebRTC 采用的是 dshow 技术，来实现枚举视频的设备信息和视频数据的采集，这意味着可以支持大多数的视频采集设备。对那些需要单独驱动程序的视频采集卡（比如海康高清卡）就无能为力了。

视频采集支持多种媒体类型，比如 I420、YUY2、RGB、UYUY 等，并可以进行帧大小和帧率控制。

## 视频媒体文件 media_file

源代码在 webrtc\modules\media_file 目录下。

该功能是可以用本地文件作为视频源，有点类似虚拟摄像头的功能；支持的格式有 AVI。

另外，WebRTC 还可以录制音视频到本地文件，比较实用的功能。

## 视频图像处理 video_processing

源代码在 webrtc\modules\video_processing 目录下。

视频图像处理针对每一帧的图像进行处理，包括明暗度检测、颜色增强、降噪处理等功能，用来提升视频质量。

## 视频显示 video_render

源代码在 webrtc\modules\video_render 目录下。

在 Windows 平台，WebRTC 采用 direct3d9 和 directdraw 的方式来显示视频，只能这样，必须这样。

## 视频编解码 video_coding

源代码在 webrtc\modules\video_coding 目录下。

WebRTC 采用 I420/VP8 编解码技术。VP8 是 google 收购 ON2 后的开源实现，并且也用在 WebM 项目中。VP8 能以更少的数据提供更高质量的视频，特别适合视频会议这样的需求。

## 视频加密 video_engine_encryption

视频加密是 WebRTC 的 video_engine 一部分，相当于视频应用层面的功能，给点对点的视频双方提供了数据上的安全保证，可以防止在 Web 上出现视频数据的泄漏。

视频加密在发送端和接收端进行加解密视频数据，密钥由视频双方协商，代价是会影响视频数据处理的性能；也可以不使用视频加密功能，这样在性能上会好些。

视频加密的数据源可能是原始的数据流，也可能是编码后的数据流。估计是编码后的数据流，这样加密代价会小一些。


> # 三、传输模块

## 网络传输与流控

对于网络音视频，数据的传输与控制是核心价值。WebRTC 采用的是成熟的 RTP/RTCP 协议来传输音视频数据。


> # 参考文献

[WebRTC Architecture](https://webrtc.org/architecture/)

[WebRTC – architecture & protocols](https://princiya777.wordpress.com/2017/08/19/webrtc-architecture-protocols/)