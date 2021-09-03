---
title: rtmp直播推流（一）－－flv格式解析与封装
date: 2015-11-13 17:35:27
tags:
- 音视频处理
categories:
- 直播
---

flv文件格式分析，可参看[RTMP中FLV流到标准h264、aac的转换](http://www.cnblogs.com/chef/archive/2012/07/18/2597279.html)，该文章写的很清晰。

flv封装格式解析，可参看[视音频数据处理入门：FLV封装格式解析](http://blog.csdn.net/leixiaohua1020/article/details/50535082)，文章图文并貌，很直观。

flv文件封装，可参看[将h.264视频流封装成flv格式文件（一.flv格式）](http://blog.csdn.net/yeyumin89/article/details/7932368)
，    [将h.264视频流封装成flv格式文件（二.开始动手）](http://blog.csdn.net/yeyumin89/article/details/7932431)

使用rtmp协议发送flv文件，可参看[rtmp协议简单解析以及用其发送h264的flv文件](http://blog.csdn.net/yeyumin89/article/details/8011362)

<!-- more -->

通过以上几篇好文，对flv文件格式，封装flv文件以及通过rtmp协议与流媒体服务器交互就有清晰的认识。

附上两张图

图一为 FLV Format with AVC Video Tag （H.264）

![flv video](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/flv-analysis-in-rtmp-live-play/flv-analysis-in-rtmp-live-play-00.png)

图二为 FLV Format with AAC Audio Tag (AAC)

![flv audio](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/flv-analysis-in-rtmp-live-play/flv-analysis-in-rtmp-live-play-01.png)