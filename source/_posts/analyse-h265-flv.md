---
title: 分析 H.265 + AAC 的 FLV 文件
date: 2017-07-01 18:38:19
tags:
- 音视频处理
---

常见的 FLV 文件里封装的是 H.264 和 AAC 数据。对于 H.265(HEVC)，FLV 支不支持呢，答案是官方版本不支持。想用 FLV 封装 H.265 数据，那该怎么搞？首先，需要一套 H.265 的编解码器，其次，就是扩展 FLV 的头 header，其实是增加对 H.265 CodecID 的支持。

今年6月6日苹果开发者大会开放了 iOS 平台的 HEVC API，也就是开发者可以调用 iOS 系统的 API 进行 H.265 硬编码了，但是只能在 iOS 11.0 及以上版本使用。目前，iOS 11.0 正式版还未正式发布，需要等到今年的9月份。不建议开发者将自己的 iOS 设备刷到 iOS 11.0 beta 版，因为升级 beta 版后非常卡。经测试，苹果的 H.265 编码出来的图像质量还是可以的，但是消耗码率较高。

苹果开放 H.265 编解码 API 势必会影响到整个 H.265 行业的发展，但 H.265 离真正落地和普及还需要时间。明年（2018年）再看 H.265 对整个音视频行业的影响。

<!-- more -->

去年，我们团队就已经实现 H.265 直播推流和播放了，采用的是 H.265 软编码和软解码器，推流端使用 500K 码率就能推送 24 帧，720P 的视频流，设备的性能消耗在可接受的范围内，播放端画质相当清晰。

言归正传，分析下 H.265+AAC 的 FLV 文件。

![H.265+AAC的FLV](http://pniof1eoj.bkt.clouddn.com/analyse-h265-flv-00.jpg)

关于 H.265 的 VPS、SPS、PPS 等知识点的解释，可参看文章：  
[VPS SPS PPS](http://blog.csdn.net/u012868357/article/details/48974967)  
[HEVC编码结构：序列参数集SPS、图像参数集PPS、视频参数集VPS](http://blog.csdn.net/lin453701006/article/details/52797104)  
[FFmpeg的HEVC解码器源代码简单分析：解析器（Parser）部分](http://blog.csdn.net/leixiaohua1020/article/details/46412607)  
[homerHEVC代码阅读（21）——基本流程](http://blog.csdn.net/nb_vol_1/article/details/50210487)  
[HEVC概念缩写对照表](http://blog.csdn.net/lin453701006/article/details/52797415)

想了解关于 FLV 的更多细节请看文章[rtmp直播推流（一）－－flv格式解析与封装](https://depthlove.github.io/2015/11/13/flv-analysis-in-rtmp-live-play)