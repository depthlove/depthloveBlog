---
title: 笔谈FFmpeg（一）
date: 2015-04-27 11:21:37
tags:
- 音视频处理
---

现在的工作是播放器库的开发，可不是调用iOS系统自带的播放器框架进行一些简单的功能和界面定制，这些没什么含量。涉及iOS开发有3个年头了，现在的工作算是有点含金量了。涉及播放器的开发，FFmpeg的架构和功能是必须清楚的。FFmpeg自带的三个工程：ffplay， ffmpeg， ffprobe。这三个工程的代码量太大，如何切入进去，一窥其中的奥秘为自己所用呢？从核心切入，编码和解码。编码和解码的核心API接口就那十几个，通过这些深入然后剖析源代码，目标就明确了。

就我个人而言，首先要了解FFmpeg整个的运行机制，哪一部分工作需要调用FFmpeg的哪一块，这个必须清楚。播放器库的开发，解码播放这就是核心，我就需要从FFmpeg的解码流程入手了。FFmpeg源代码结构图 - 解码 这篇文章太好了，看得我两眼放光，精华。这篇文章读透了，完全可以把控FFmpeg的使用。我接下来的学习任务，那就是认真研读和敲代码研习，光看是不顶用的，需要动手写。

<!-- more -->

[FFmpeg源代码结构图 - 解码](http://blog.csdn.net/leixiaohua1020/article/details/44220151)中包含的信息太多了，对于在音视频领域中的初学者来说，首先要看[FFmpeg源代码结构图 - 解码](http://blog.csdn.net/leixiaohua1020/article/details/44220151) 中提到的[简单的基于FFMPEG+SDL的视频播放器 ver2 （采用SDL2.0）](http://blog.csdn.net/leixiaohua1020/article/details/38868499)入手。心急吃不了热豆腐，心急就不能静下心来搞懂深层次的问题。FFmpeg的解码过程调用的API依次为：

　　　　　　　　　　　　　　　　　　开始---->

　　　　　　　　　　　　　　　　　　av_register_all();

　　　　　　　　　　　　　　　　　　avformat_open_input()；

　　　　　　　　　　　　　　　　　　av_find_stream_info();

　　　　　　　　　　　　　　　　　　avcodec_find_decoder();

　　　　　　　　　　　　　　　　　　av_read_frame();

　　　　　　　　　　　　　　　　　　获取到packet---->

　　　　　　　　　　　　　　　　　　avcodec_decode_video2();

对于FFmpeg的解码流程，先知道了有上面那些方法，但是这些方法是用来做什么，从方法名上能看出其功能，要深入的理解才行。借鉴别人的经验，收集有效的资源是非常重要的。对FFmpeg解码流程讲解的比较好的一篇博文是 [FFMpeg的解码流程](http://www.cnblogs.com/moonvan/archive/2011/10/22/2221263.html) ，配合文章  [ffmpeg解码流程](http://blog.csdn.net/ownwell/article/details/8113980) 一起服下，效果更好。因为当当看 [简单的基于FFMPEG+SDL的视频播放器 ver2 （采用SDL2.0）](http://blog.csdn.net/leixiaohua1020/article/details/38868499) 还不足以搞透整个流程。通过研习这三篇文章，整个流程和方法功能应该就吃透了。

学习任何东西什么时候该从局部把控全局，那就是有了自己的切入点之后，在这个点上摸爬滚打搞得比较熟练之后，就需要把控全局，对FFmpeg框架的整体要有把控。对于FFmpeg框架讲解的比较好的入门读物是 [FFMpeg框架代码阅读](http://blog.csdn.net/wstarx/article/details/1572393)。