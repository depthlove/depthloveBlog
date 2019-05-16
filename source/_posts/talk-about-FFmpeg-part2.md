---
title: 笔谈FFmpeg（二）
date: 2015-04-28 15:04:58
tags: 
- 音视频处理
categories:
- 直播
---

经过前面的学习对FFmpeg的基本流程已经很熟悉了，现在到了掌握其中细节的时候了，用FFmpeg做播放器解码操作中，涉及到了一些结构体，这些结构之间到底有什么关系，它们是怎样协同工作的呢。文章 FFMPEG中最关键的结构体之间的关系 对这些结构间的关系进行了分析，详细内容如下：

FFMPEG中结构体很多。最关键的结构体可以分成以下几类：

<!-- more -->

#### a) 解协议（http,rtsp,rtmp,mms）

AVIOContext，URLProtocol，URLContext主要存储视音频使用的协议的类型以及状态。URLProtocol存储输入视音频使用的封装格式。每种协议都对应一个URLProtocol结构。（注意：FFMPEG中文件也被当做一种协议“file”）

#### b) 解封装（flv,avi,rmvb,mp4）

AVFormatContext主要存储视音频封装格式中包含的信息；AVInputFormat存储输入视音频使用的封装格式。每种视音频封装格式都对应一个AVInputFormat 结构。

#### c) 解码（h264,mpeg2,aac,mp3）

每个AVStream存储一个视频/音频流的相关数据；每个AVStream对应一个AVCodecContext，存储该视频/音频流使用解码方式的相关数据；每个AVCodecContext中对应一个AVCodec，包含该视频/音频对应的解码器。每种解码器都对应一个AVCodec结构。

#### d)存数据

视频的话，每个结构一般是存一帧；音频可能有好几帧

解码前数据：AVPacket

解码后数据：AVFrame

他们之间的对应关系如下所示：

![流程图](http://img.blog.csdn.net/20130914204051125?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvbGVpeGlhb2h1YTEwMjA=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

上面提到的这些结构到底是干嘛用的，中国传媒大学的一个博士写了一系列的结构体的分析的文章，在这里列一个列表，需要好好看下：

##### [FFMPEG结构体分析：AVFrame](http://blog.csdn.net/leixiaohua1020/article/details/14214577)

##### [FFMPEG结构体分析：AVFormatContext](http://blog.csdn.net/leixiaohua1020/article/details/14214705)

##### [FFMPEG结构体分析：AVCodecContext](http://blog.csdn.net/leixiaohua1020/article/details/14214859)

##### [FFMPEG结构体分析：AVIOContext](http://blog.csdn.net/leixiaohua1020/article/details/14215369)

##### [FFMPEG结构体分析：AVCodec](http://blog.csdn.net/leixiaohua1020/article/details/14215833)

##### [FFMPEG结构体分析：AVStream](http://blog.csdn.net/leixiaohua1020/article/details/14215821)

##### [FFMPEG结构体分析：AVPacket](http://blog.csdn.net/leixiaohua1020/article/details/14215755)

