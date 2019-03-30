---
title: 使用 VPS 搭建 live555 流媒体服务器
date: 2019-03-30 08:24:31
tags:
- 音视频处理
- 服务器开发
---

在上一篇文章 [使用搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server) 中提到了我购买了 VPS 服务资源，所谓物尽其用，仅让其充当 VPN 服务的工具有点浪费，可以在上面跑一些其它服务，比如流媒体直播服务、流媒体转码服务等。关于主机购买，也可以购买国内供应商的提供的主机服务，像阿里云、腾讯云、百度云等，可以关注他们的一些促销活动，在优惠力度大的时候囤机。

我的 VPS 服务器的操作系统为：
```
Operating system:  Centos 7 x86_64 bbr
```

<!-- more -->

### 一、登陆 VPS 服务器
我使用的是 MacBook Pro 笔记本，在 MacBook Pro 笔记本上的终端输入命令 ssh root@IP地址 -p ssh端口，其中 IP 地址和 SSH 端口换成你自己的 VPS 信息

```
suntongmiandeMacBook-Pro:~ suntongmian$ ssh root@111.11.111.111 -p 1111
```

执行命令后的结果如下：

```
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ ssh root@111.11.111.111 -p 1111
root@111.11.111.111's password: 
[root@host ~]# 
```

### 二、安装 gcc 编译器
给 VPS 主机安装 gcc 编译器

```
[root@host ~]# yum install gcc-c++
```

### 三、下载 live55 源码
在主机根目录创建目录 **streamingserver**

```
[root@host ~]# 
[root@host ~]# mkdir streamingserver
[root@host ~]# 
```

进入目录 **streamingserver**

```
[root@host ~]# 
[root@host ~]# cd streamingserver
[root@host streamingserver]# 
```

从 [live555 官网](live555.com)下载 live555 源码
在终端执行命令下载或者直接在官网下载，以在终端执行命令下载为例子

```
[root@host streamingserver]# curl -O http://www.live555.com/live.2019.03.06.tar.gz
```

### 四、解压
在终端执行文件的解压缩命令

```
[root@host streamingserver]# tar -xvf live.2019.03.06.tar.gz
```

使用 **ls** 命令查看当前目录下的文件

```
[root@host streamingserver]# 
[root@host streamingserver]# ls
live  live.2019.03.06.tar.gz
[root@host streamingserver]# 
```

### 五、编译
第一步：进入 live55 源码目录 live

```
[root@host streamingserver]# cd live
```

第二步：执行脚本

```
[root@host live]# ./genMakefiles linux-64bit 
```

因为我的系统是 Centos, 64bit，执行的是上面的脚本。如果系统是 Mac 系统，那么就要执行脚本 ./genMakefiles macosx


第三步：执行编译

```
[root@host live]# make
```

### 六、启动流媒体服务
第一步：进入 mediaServer 目录

```
[root@host live]# 
[root@host live]# cd mediaServer
[root@host mediaServer]# 
```

第二步：启动流媒体服务

```
[root@host mediaServer]# 
[root@host mediaServer]# ./live555MediaServer
```

命令执行后的结果如下：

```
[root@host mediaServer]# 
[root@host mediaServer]# ./live555MediaServer
LIVE555 Media Server
	version 0.96 (LIVE555 Streaming Media library version 2019.03.06).
Play streams from this server using the URL
	rtsp://111.11.111.111/<filename>
where <filename> is a file present in the current directory.
Each file's type is inferred from its name suffix:
	".264" => a H.264 Video Elementary Stream file
	".265" => a H.265 Video Elementary Stream file
	".aac" => an AAC Audio (ADTS format) file
	".ac3" => an AC-3 Audio file
	".amr" => an AMR Audio file
	".dv" => a DV Video file
	".m4e" => a MPEG-4 Video Elementary Stream file
	".mkv" => a Matroska audio+video+(optional)subtitles file
	".mp3" => a MPEG-1 or 2 Audio file
	".mpg" => a MPEG-1 or 2 Program Stream (audio+video) file
	".ogg" or ".ogv" or ".opus" => an Ogg audio and/or video file
	".ts" => a MPEG Transport Stream file
		(a ".tsx" index file - if present - provides server 'trick play' support)
	".vob" => a VOB (MPEG-2 video with AC-3 audio) file
	".wav" => a WAV Audio file
	".webm" => a WebM audio(Vorbis)+video(VP8) file
See http://www.live555.com/mediaServer/ for additional documentation.
(We use port 80 for optional RTSP-over-HTTP tunneling, or for HTTP live streaming (for indexed Transport Stream files only).)
```

从上面显示的信息可看出，live555 默认支持 .264, .265, .aac, ac3, .amr, .dv, .m4e, .mkv, .mp3, .mpg, .ogg, .ts, .vob, .wav, .webm 视频格式。

### 七、本地文件上传到服务器
第一步：获取 .mkv 格式的视频文件

如果在网络上找不到合适的 .mkv 格式的视频文件，那么可以使用 ffmpeg 转码获取。ffmpeg 的安装，可参看我的文章 [在Mac OSX上安装ffmpeg && ffmpeg命令行将h264封装为mp4](https://depthlove.github.io/2015/09/24/install-ffmpeg-to-MacOSX-and-use-ffmpeg-to-transform-h264-to-mp4)


在 MacBook Pro 笔记本的终端输入 ffmpeg 转码命令

```
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ ffmpeg -i SampleVideo_1280x720_10mb.mp4 -vcodec copy -acodec copy output.mkv 
```

执行结果如下：

```
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ ls
SampleVideo_1280x720_10mb.mp4
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ ffmpeg -i SampleVideo_1280x720_10mb.mp4 -vcodec copy -acodec copy output.mkv 
ffmpeg version 4.1.2 Copyright (c) 2000-2019 the FFmpeg developers
  built with Apple LLVM version 10.0.0 (clang-1000.11.45.5)
  configuration: --prefix=/usr/local/Cellar/ffmpeg/4.1.2 --enable-shared --enable-pthreads --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags='-I/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/openjdk-11.0.2.jdk/Contents/Home/include/darwin' --host-ldflags= --enable-ffplay --enable-gnutls --enable-gpl --enable-libaom --enable-libbluray --enable-libmp3lame --enable-libopus --enable-librubberband --enable-libsnappy --enable-libtesseract --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 --enable-libxvid --enable-lzma --enable-libfontconfig --enable-libfreetype --enable-frei0r --enable-libass --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-librtmp --enable-libspeex --enable-videotoolbox --disable-libjack --disable-indev=jack --enable-libaom --enable-libsoxr
  libavutil      56. 22.100 / 56. 22.100
  libavcodec     58. 35.100 / 58. 35.100
  libavformat    58. 20.100 / 58. 20.100
  libavdevice    58.  5.100 / 58.  5.100
  libavfilter     7. 40.101 /  7. 40.101
  libavresample   4.  0.  0 /  4.  0.  0
  libswscale      5.  3.100 /  5.  3.100
  libswresample   3.  3.100 /  3.  3.100
  libpostproc    55.  3.100 / 55.  3.100
Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'SampleVideo_1280x720_10mb.mp4':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    creation_time   : 1970-01-01T00:00:00.000000Z
    encoder         : Lavf53.24.2
  Duration: 00:01:02.32, start: 0.000000, bitrate: 1347 kb/s
    Stream #0:0(und): Video: h264 (Main) (avc1 / 0x31637661), yuv420p, 1280x720 [SAR 1:1 DAR 16:9], 959 kb/s, 25 fps, 25 tbr, 12800 tbn, 50 tbc (default)
    Metadata:
      creation_time   : 1970-01-01T00:00:00.000000Z
      handler_name    : VideoHandler
    Stream #0:1(und): Audio: aac (LC) (mp4a / 0x6134706D), 48000 Hz, 5.1, fltp, 383 kb/s (default)
    Metadata:
      creation_time   : 1970-01-01T00:00:00.000000Z
      handler_name    : SoundHandler
Output #0, matroska, to 'output.mkv':
  Metadata:
    major_brand     : isom
    minor_version   : 512
    compatible_brands: isomiso2avc1mp41
    encoder         : Lavf58.20.100
    Stream #0:0(und): Video: h264 (Main) (avc1 / 0x31637661), yuv420p, 1280x720 [SAR 1:1 DAR 16:9], q=2-31, 959 kb/s, 25 fps, 25 tbr, 1k tbn, 12800 tbc (default)
    Metadata:
      creation_time   : 1970-01-01T00:00:00.000000Z
      handler_name    : VideoHandler
    Stream #0:1(und): Audio: aac (LC) ([255][0][0][0] / 0x00FF), 48000 Hz, 5.1, fltp, 383 kb/s (default)
    Metadata:
      creation_time   : 1970-01-01T00:00:00.000000Z
      handler_name    : SoundHandler
Stream mapping:
  Stream #0:0 -> #0:0 (copy)
  Stream #0:1 -> #0:1 (copy)
Press [q] to stop, [?] for help
frame= 1557 fps=0.0 q=-1.0 Lsize=   10249kB time=00:01:02.29 bitrate=1347.9kbits/s speed= 973x    
video:7298kB audio:2919kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: 0.316002%
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ ls
SampleVideo_1280x720_10mb.mp4	output.mkv
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
```

第二步：上传本地文件到远端服务器

我使用的是 MacBook Pro 笔记本，在 MacBook Pro 笔记本上的终端上执行下面的命令，将视频文件上传到 VPS 服务器上。

```
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ scp -P 1111 output.mkv root@111.11.111.111:/root/streamingserver/live/mediaServer
```

命令执行后的结果如下：

```
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ scp -P 1111 output.mkv root@111.11.111.111:/root/streamingserver/live/mediaServer
root@111.11.111.111's password: 
output.mkv                                                                                           100%   30MB 511.1KB/s   01:00    
suntongmiandeMacBook-Pro:myTestVideo suntongmian$ 
```

其中，**myTestVideo** 是我的 MacBook Pro 笔记本上存放测试视频的文件夹。**/root/streamingserver/live/mediaServer** 为 VPS 主机的目录层级。

关于 scp 命令的使用，可参看文章 [Linux SSH远程文件/目录传输命令scp](https://www.vpser.net/manage/scp.html)

第二步：检测文件是否上传成功

在 VPS 主机上执行命令 **ls** 查看相应的目录下是否存在文件 **output.mkv**。若存在 **output.mkv**，就说明上面的第一步操作成功了。

```
[root@host mediaServer]# 
[root@host mediaServer]# ls
COPYING                DynamicRTSPServer.o     Makefile       version.hh
COPYING.LESSER         live555MediaServer      Makefile.head
DynamicRTSPServer.cpp  live555MediaServer.cpp  Makefile.tail
DynamicRTSPServer.hh   live555MediaServer.o    output.mkv
[root@host mediaServer]# 
```

### 八、重新启动流媒体服务
第一步：使用 ctrl+c 终止之前启动的流媒体服务

执行结果如下：

```
^C
[root@host mediaServer]# 
```

第二步：重新启动流媒体服务

```
[root@host mediaServer]# 
[root@host mediaServer]# ./live555MediaServer
```

### 九、测试视频流
第一步：安装 VLC 视频播放器。我使用的是 MacBook Pro 笔记本，在笔记本上下载并安装了 VLC 视频播放器。

第二步：播放视频流。在 VLC 中打开视频流地址 **rtsp://111.11.111.111/output.mkv**，即可看到 live555 服务器推送出来的视频流。



