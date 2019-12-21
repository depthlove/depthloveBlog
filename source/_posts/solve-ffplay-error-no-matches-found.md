---
title: ffplay 播放视频报错 no matches found 的解决方法
date: 2019-12-20 19:18:06
tags:
- 音视频处理
- FFmpeg
categories:
- FFmpeg
---

做音视频相关的产品，不可避免的要 dump 一些音视频数据用来分析音视频处理逻辑的正确性。FFmpeg 工具会经常用到，比如用 ffplay 播放视频。今天在分析一段视频数据时，想用 ffplay 来播放视频看看数据的正确性，结果在执行命令后遇到了 “zsh: no matches found: 1920*1024” 报错，导致无法使用 ffplay。

# 遇到问题

在给出解决方案前，先描述下问题是如何产生的。

在 Mac 电脑的终端下执行命令：

```
ffplay -f rawvideo -pixel_format yuv420p -video_size 1920*1024 -framerate 15 dump-1920x1024.yuv
```

执行后，终端显示结果为：**zsh: no matches found: 1920*1024**。从这个报错信息可以看出，“*” 这个符号没有被支持。

<!-- more -->

# 解决问题

下面来讲述下，如何解决这个问题的。Google 浏览器是个好东西，但检索结果中看似有关联的问题，却从中找不到自己想要的解决问题的线索。我花了点时间，从一篇看似无关联的文章 [How to get rid of “No match found” when running “rm *”](https://unix.stackexchange.com/questions/310540/how-to-get-rid-of-no-match-found-when-running-rm) 中找到了解决问题的方法，这才解决上面的问题。

在终端执行命令：

```
setopt +o nomatch
```

再次执行播放视频数据的命令：

```
ffplay -f rawvideo -pixel_format yuv420p -video_size 1920*1024 -framerate 15 dump-1920x1024.yuv
```

执行后，终端能正常调用 ffpaly 播放视频。

```
ffplay version 4.2.1 Copyright (c) 2003-2019 the FFmpeg developers
  built with Apple clang version 11.0.0 (clang-1100.0.33.8)
  configuration: --prefix=/usr/local/Cellar/ffmpeg/4.2.1_1 --enable-shared --enable-pthreads --enable-version3 --enable-avresample --cc=clang --host-cflags='-I/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home/include/darwin -fno-stack-check' --host-ldflags= --enable-ffplay --enable-gnutls --enable-gpl --enable-libaom --enable-libbluray --enable-libmp3lame --enable-libopus --enable-librubberband --enable-libsnappy --enable-libtesseract --enable-libtheora --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-libxvid --enable-lzma --enable-libfontconfig --enable-libfreetype --enable-frei0r --enable-libass --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-librtmp --enable-libspeex --enable-libsoxr --enable-videotoolbox --disable-libjack --disable-indev=jack
  libavutil      56. 31.100 / 56. 31.100
  libavcodec     58. 54.100 / 58. 54.100
  libavformat    58. 29.100 / 58. 29.100
  libavdevice    58.  8.100 / 58.  8.100
  libavfilter     7. 57.100 /  7. 57.100
  libavresample   4.  0.  0 /  4.  0.  0
  libswscale      5.  5.100 /  5.  5.100
  libswresample   3.  5.100 /  3.  5.100
  libpostproc    55.  5.100 / 55.  5.100
[rawvideo @ 0x7fdfda041200] Estimating duration from bitrate, this may be inaccurate
Input #0, rawvideo, from 'dump-1920x1024.yuv':
  Duration: 00:00:10.27, start: 0.000000, bitrate: 353894 kb/s
    Stream #0:0: Video: rawvideo (I420 / 0x30323449), yuv420p, 1920x1024, 353894 kb/s, 15 tbr, 15 tbn, 15 tbc
   9.34 M-V:  0.000 fd=   0 aq=    0KB vq=17280KB sq=    0B f=0/0
```

# 参考文献

[1]  [How to get rid of “No match found” when running “rm *”](https://unix.stackexchange.com/questions/310540/how-to-get-rid-of-no-match-found-when-running-rm) 
