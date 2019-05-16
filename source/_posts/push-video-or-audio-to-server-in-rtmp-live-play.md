---
title: rtmp直播推流（二）－－将音频／视频推送到流媒体服务器
date: 2015-11-16 18:27:30
tags:
- 音视频处理
- iOS
---

参考我之前写的一篇文章[利用FFmpeg+x264将iOS摄像头实时视频流编码为h264文件](https://depthlove.github.io/2015/09/18/use-ffmpeg-and-x264-encode-iOS-camera-video-to-h264/)

参看文章[ffmpeg综合应用示例（一）——摄像头直播 ](http://blog.csdn.net/nonmarking/article/details/48022387)，       [ffmpeg综合应用示例（四）——摄像头直播的视音频同步](http://blog.csdn.net/nonmarking/article/details/50522413)

参看文章[最简单的基于FFmpeg的移动端例子：IOS 推流器](http://blog.csdn.net/leixiaohua1020/article/details/47072519)，      [ 最简单的基于FFmpeg的推流器（以推送RTMP为例）](http://blog.csdn.net/leixiaohua1020/article/details/39803457)

<!-- more -->

使用librtmp发布h.264可参看文章[最简单的基于librtmp的示例：发布H.264（H.264通过RTMP发布）](http://blog.csdn.net/leixiaohua1020/article/details/42105049)，     [最简单的基于librtmp的示例：发布（FLV通过RTMP发布）](http://blog.csdn.net/leixiaohua1020/article/details/42104945)

通过以上文章，就可以将采集到的音频／视频数据推送到流媒体服务器，至于观看延迟方面，需要结合实际情况区处理了。