title: 在Mac OSX上安装ffmpeg && ffmpeg命令行将h264封装为mp4
date: 2015-09-24 13:09:39
tags:
- 音视频处理
---
ffmpeg功能强大，可以通过命令行来对音视频进行处理。为了使用其功能，我在Mac上对其进行了安装。

我的Mac OS X 系统版本：OS X Yosemite, 10.10.14

<!-- more -->

关于ffmpeg在Mac OS X上的编译，FFmpeg上有官方文档说明：[https://trac.ffmpeg.org/wiki/CompilationGuide/MacOSX](https://trac.ffmpeg.org/wiki/CompilationGuide/MacOSX)。该文档给出了3种方法：

* ffmpeg through Homebrew
* Compiling FFmpeg yourself
* Manual install of the dependencies without Homebrew

看了这三种方法的官方说明后，我选择了第一种，因为最简单。

### 首先，Mac上要安装Homebrew

在终端执行命令，**ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"**

```
devtemobideMac-mini:~ sunminmin$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

==> This script will install:

/usr/local/bin/brew

/usr/local/Library/...

/usr/local/share/man/man1/brew.1

 

Press RETURN to continue or any other key to abort

==> /usr/bin/sudo /bin/chmod g+rwx /Library/Caches/Homebrew

Password:

==> Downloading and installing Homebrew...

 

 

 

remote: Counting objects: 225571, done.

remote: Compressing objects: 100% (59354/59354), done.

remote: Total 225571 (delta 165037), reused 225482 (delta 164969)

Receiving objects: 100% (225571/225571), 51.57 MiB | 1.19 MiB/s, done.

Resolving deltas: 100% (165037/165037), done.

From https://github.com/Homebrew/homebrew

 * [new branch]      master     -> origin/master

HEAD is now at 82d7dc4 tomcat: update 8.0.17 bottle.

==> Installation successful!

==> Next steps

Run `brew doctor` before you install anything

Run `brew help` to get started

```


### 其次，安装ffmpeg

在终端执行命令，**brew install ffmpeg**


```
devtemobideMac-mini:~ sunminmin$ brew install ffmpeg
==> Installing dependencies for ffmpeg: x264, lame, libvo-aacenc, xvid
==> Installing ffmpeg dependency: x264
==> Downloading https://homebrew.bintray.com/bottles/x264-r2533.yosemite.bottle.
######################################################################## 100.0%
==> Pouring x264-r2533.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/x264/r2533: 9 files, 3.4M
==> Installing ffmpeg dependency: lame
==> Downloading https://homebrew.bintray.com/bottles/lame-3.99.5.yosemite.bottle
######################################################################## 100.0%
==> Pouring lame-3.99.5.yosemite.bottle.1.tar.gz
🍺  /usr/local/Cellar/lame/3.99.5: 25 files, 2.1M
==> Installing ffmpeg dependency: libvo-aacenc
==> Downloading https://homebrew.bintray.com/bottles/libvo-aacenc-0.1.3.yosemite
######################################################################## 100.0%
==> Pouring libvo-aacenc-0.1.3.yosemite.bottle.tar.gz
🍺  /usr/local/Cellar/libvo-aacenc/0.1.3: 15 files, 336K
==> Installing ffmpeg dependency: xvid
==> Downloading https://homebrew.bintray.com/bottles/xvid-1.3.3.yosemite.bottle.
######################################################################## 100.0%
==> Pouring xvid-1.3.3.yosemite.bottle.2.tar.gz
🍺  /usr/local/Cellar/xvid/1.3.3: 9 files, 1.3M
==> Installing ffmpeg
==> Downloading https://homebrew.bintray.com/bottles/ffmpeg-2.6.3.yosemite.bottle.ta
######################################################################## 100.0%
==> Pouring ffmpeg-2.6.3.yosemite.bottle.tar.gz
==> Caveats
FFmpeg has been built without libfaac for licensing reasons;
libvo-aacenc is used by default.
To install with libfaac, you can:
  brew reinstall ffmpeg --with-faac

You can also use the experimental FFmpeg encoder, libfdk-aac, or
libvo_aacenc to encode AAC audio:
  ffmpeg -i input.wav -c:a aac -strict experimental output.m4a
Or:
  brew reinstall ffmpeg --with-fdk-aac
  ffmpeg -i input.wav -c:a libfdk_aac output.m4a
==> Summary
🍺  /usr/local/Cellar/ffmpeg/2.6.3: 204 files, 42M

```

### 再次，查看ffmpeg info

在终端执行命令，**brew info ffmpeg**


```
devtemobideMac-mini:~ sunminmin$ brew info ffmpeg
ffmpeg: stable 2.6.3 (bottled), HEAD
Play, record, convert, and stream audio and video
https://ffmpeg.org/
/usr/local/Cellar/ffmpeg/2.6.3 (204 files, 42M) *
  Poured from bottle
From: https://github.com/Homebrew/homebrew/blob/master/Library/Formula/ffmpeg.rb
==> Dependencies
Build: pkg-config ✘, texi2html ✘, yasm ✘
Recommended: x264 ✔, lame ✔, libvo-aacenc ✔, xvid ✔
Optional: faac ✘, fontconfig ✘, freetype ✘, theora ✘, libvorbis ✘, libvpx ✘, rtmpdump ✘, opencore-amr ✘, libass ✘, openjpeg ✘, speex ✘, schroedinger ✘, fdk-aac ✘, opus ✘, frei0r ✘, libcaca ✘, libbluray ✘, libsoxr ✘, libquvi ✘, libvidstab ✘, x265 ✘, openssl ✘, libssh ✘, webp ✘
==> Options
--with-faac
	Build with faac support
--with-fdk-aac
	Enable the Fraunhofer FDK AAC library
--with-ffplay
	Enable FFplay media player
--with-fontconfig
	Build with fontconfig support
--with-freetype
	Build with freetype support
--with-frei0r
	Build with frei0r support
--with-libass
	Enable ASS/SSA subtitle format
--with-libbluray
	Build with libbluray support
--with-libcaca
	Build with libcaca support
--with-libquvi
	Build with libquvi support
--with-libsoxr
	Enable the soxr resample library
--with-libssh
	Enable SFTP protocol via libssh
--with-libvidstab
	Enable vid.stab support for video stabilization
--with-libvorbis
	Build with libvorbis support
--with-libvpx
	Build with libvpx support
--with-opencore-amr
	Enable Opencore AMR NR/WB audio format
--with-openjpeg
	Enable JPEG 2000 image format
--with-openssl
	Enable SSL support
--with-opus
	Build with opus support
--with-rtmpdump
	Enable RTMP protocol
--with-schroedinger
	Enable Dirac video format
--with-speex
	Build with speex support
--with-theora
	Build with theora support
--with-tools
	Enable additional FFmpeg tools
--with-webp
	Enable using libwebp to encode WEBP images
--with-x265
	Enable x265 encoder
--without-lame
	Disable MP3 encoder
--without-libvo-aacenc
	Disable VisualOn AAC encoder
--without-qtkit
	Disable deprecated QuickTime framework
--without-x264
	Disable H.264 encoder
--without-xvid
	Disable Xvid MPEG-4 video encoder
--HEAD
	Install HEAD version
==> Caveats
FFmpeg has been built without libfaac for licensing reasons;
libvo-aacenc is used by default.
To install with libfaac, you can:
  brew reinstall ffmpeg --with-faac

You can also use the experimental FFmpeg encoder, libfdk-aac, or
libvo_aacenc to encode AAC audio:
  ffmpeg -i input.wav -c:a aac -strict experimental output.m4a
Or:
  brew reinstall ffmpeg --with-fdk-aac
  ffmpeg -i input.wav -c:a libfdk_aac output.m4a
  
```

经过这3步，现在就可以使用ffmpeg的强大功能了。

现在ffmpeg的版本更新很快，今年3月份发布了 FFmpeg 2.6.1，7月份发布了 FFmpeg 2.7.2，中间还有一些其它版本，比如2.7，2.7.1，这些版本我都在iOS平台上编译使用过，今年9月份，FFmpeg 的版本更新到了2.8。今年，我见证了FFmpeg更新最频繁的的时刻。

经过前面的3步，在Mac上安装了 ffmpeg 2.6.3 的版本，过段时间，homebrew上ffmpeg 的安装源就会更新，若想升级ffmpeg，就需要执行下面的第4步操作了。

### 最后，升级ffmpeg的版本

若想升级ffmpeg的版本，可以在终端执行命令，**brew update && brew upgrade ffmpeg**


## 实例

安装好了ffmpeg，就要试试其功能了。采用文章[利用x264将iOS摄像头实时视频流编码为h264文件](http://depthlove.github.io/2015/09/17/use-x264-encode-iOS-camera-video-to-h264/)配套工程[X264-Encode-for-iOS](https://github.com/depthlove/X264-Encode-for-iOS)中的**h264文件**，该文件地址为[2015-09-17 18:05:20.h264](https://github.com/depthlove/X264-Encode-for-iOS/blob/master/myRecordH264Vieo/2015-09-17%2018:05:20.h264)，使用ffmpeg 命令将其打包为 **.mp4容器格式的文件**

将该h264文件下载，在终端上，执行命令进入存放该文件的目录

```
devtemobideMac-mini:~ sunminmin$ cd /Users/dev.temobi/Desktop/sunmmMainPrj/ZZ_Z_Github_clone

```

进入到该目录后，执行命令，**ffmpeg -i 2015-09-17\ 18_05_20.h264  2015-09-17.mp4**

```
devtemobideMac-mini:ZZ_Z_Github_clone sunminmin$ ffmpeg -i 2015-09-17\ 18_05_20.h264  2015-09-17.mp4
ffmpeg version 2.6.3 Copyright (c) 2000-2015 the FFmpeg developers
  built with Apple LLVM version 6.1.0 (clang-602.0.53) (based on LLVM 3.6.0svn)
  configuration: --prefix=/usr/local/Cellar/ffmpeg/2.6.3 --enable-shared --enable-pthreads --enable-gpl --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags= --host-ldflags= --enable-libx264 --enable-libmp3lame --enable-libvo-aacenc --enable-libxvid --enable-vda
  libavutil      54. 20.100 / 54. 20.100
  libavcodec     56. 26.100 / 56. 26.100
  libavformat    56. 25.101 / 56. 25.101
  libavdevice    56.  4.100 / 56.  4.100
  libavfilter     5. 11.102 /  5. 11.102
  libavresample   2.  1.  0 /  2.  1.  0
  libswscale      3.  1.101 /  3.  1.101
  libswresample   1.  1.100 /  1.  1.100
  libpostproc    53.  3.100 / 53.  3.100
Input #0, h264, from '2015-09-17 18_05_20.h264':
  Duration: N/A, bitrate: N/A
    Stream #0:0: Video: h264 (Constrained Baseline), yuv420p, 480x360, 15 fps, 15 tbr, 1200k tbn, 30 tbc
[libx264 @ 0x7fada2818000] using cpu capabilities: MMX2 SSE2Fast SSSE3 SSE4.2 AVX
[libx264 @ 0x7fada2818000] profile High, level 2.1
[libx264 @ 0x7fada2818000] 264 - core 144 r2533 c8a773e - H.264/MPEG-4 AVC codec - Copyleft 2003-2015 - http://www.videolan.org/x264.html - options: cabac=1 ref=3 deblock=1:0:0 analyse=0x3:0x113 me=hex subme=7 psy=1 psy_rd=1.00:0.00 mixed_ref=1 me_range=16 chroma_me=1 trellis=1 8x8dct=1 cqm=0 deadzone=21,11 fast_pskip=1 chroma_qp_offset=-2 threads=6 lookahead_threads=1 sliced_threads=0 nr=0 decimate=1 interlaced=0 bluray_compat=0 constrained_intra=0 bframes=3 b_pyramid=2 b_adapt=1 b_bias=0 direct=1 weightb=1 open_gop=0 weightp=2 keyint=250 keyint_min=15 scenecut=40 intra_refresh=0 rc_lookahead=40 rc=crf mbtree=1 crf=23.0 qcomp=0.60 qpmin=0 qpmax=69 qpstep=4 ip_ratio=1.40 aq=1:1.00
Output #0, mp4, to '2015-09-17.mp4':
  Metadata:
    encoder         : Lavf56.25.101
    Stream #0:0: Video: h264 (libx264) ([33][0][0][0] / 0x0021), yuv420p, 480x360, q=-1--1, 15 fps, 15360 tbn, 15 tbc
    Metadata:
      encoder         : Lavc56.26.100 libx264
Stream mapping:
  Stream #0:0 -> #0:0 (h264 (native) -> h264 (libx264))
Press [q] to stop, [?] for help
frame=   64 fps=0.0 q=27.0 size=      60kB time=00:00:00.80 bitrate= 609.7kbits/s   frame=   87 fps= 85 q=27.0 size=     187kB time=00:00:02.33 bitrate= 655.2kbits/s   frame=  120 fps= 77 q=27.0 size=     366kB time=00:00:04.53 bitrate= 661.5kbits/s   frame=  149 fps= 72 q=27.0 size=     444kB time=00:00:06.46 bitrate= 562.4kbits/s   frame=  178 fps= 69 q=27.0 size=     508kB time=00:00:08.40 bitrate= 495.4kbits/s   frame=  196 fps= 56 q=-1.0 Lsize=     651kB time=00:00:12.93 bitrate= 412.2kbits/s    
video:648kB audio:0kB subtitle:0kB other streams:0kB global headers:0kB muxing overhead: 0.389284%
[libx264 @ 0x7fada2818000] frame I:2     Avg QP:20.10  size:  5888
[libx264 @ 0x7fada2818000] frame P:126   Avg QP:22.22  size:  4340
[libx264 @ 0x7fada2818000] frame B:68    Avg QP:23.94  size:  1537
[libx264 @ 0x7fada2818000] consecutive B-frames: 43.9% 27.6%  6.1% 22.4%
[libx264 @ 0x7fada2818000] mb I  I16..4: 31.4% 51.4% 17.2%
[libx264 @ 0x7fada2818000] mb P  I16..4:  8.6% 10.2%  4.6%  P16..4: 46.2% 11.9%  4.2%  0.0%  0.0%    skip:14.2%
[libx264 @ 0x7fada2818000] mb B  I16..4:  1.1%  0.6%  0.6%  B16..8: 52.3%  4.9%  0.8%  direct: 3.2%  skip:36.5%  L0:51.0% L1:45.1% BI: 3.9%
[libx264 @ 0x7fada2818000] 8x8 transform intra:43.2% inter:63.2%
[libx264 @ 0x7fada2818000] coded y,uvDC,uvAC intra: 42.6% 57.1% 10.4% inter: 19.2% 28.2% 0.7%
[libx264 @ 0x7fada2818000] i16 v,h,dc,p: 20% 51% 10% 19%
[libx264 @ 0x7fada2818000] i8 v,h,dc,ddl,ddr,vr,hd,vl,hu: 24% 38% 22%  2%  2%  2%  4%  2%  5%
[libx264 @ 0x7fada2818000] i4 v,h,dc,ddl,ddr,vr,hd,vl,hu: 21% 43% 12%  3%  3%  3%  6%  4%  5%
[libx264 @ 0x7fada2818000] i8c dc,h,v,p: 51% 32% 14%  3%
[libx264 @ 0x7fada2818000] Weighted P-Frames: Y:7.1% UV:5.6%
[libx264 @ 0x7fada2818000] ref P L0: 78.9% 10.4%  8.3%  2.3%  0.1%
[libx264 @ 0x7fada2818000] ref B L0: 93.9%  5.6%  0.5%
[libx264 @ 0x7fada2818000] ref B L1: 96.2%  3.8%
[libx264 @ 0x7fada2818000] kb/s:405.98

```

到此，h264文件封装为.mp4格式的过程结束。

查看2015-09-17.mp4 文件，如图

![mp4文件详情](http://images2015.cnblogs.com/blog/719115/201509/719115-20150924200951959-1409932132.png)

2015-09-17.mp4 文件可以使用Quick Time Player，VLC 正常播放。

* 2015-09-17.mp4 文件的下载地址为：[2015-09-17.mp4](https://github.com/depthlove/test-files/blob/master/2015-09-17.mp4)
* 2015-09-17 18:05:20.h264 文件的下载地址为：[2015-09-17 18:05:20.h264](https://github.com/depthlove/X264-Encode-for-iOS/blob/master/myRecordH264Vieo/2015-09-17%2018:05:20.h264)

