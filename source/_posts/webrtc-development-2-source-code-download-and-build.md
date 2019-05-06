---
title: WebRTC 开发（二）源码下载与编译
date: 2019-05-02 13:35:17
tags:
- WebRTC
- 音视频处理
---

在使用任何工具之前，我们都有必要对工具做大概地的了解，做到粗犷但不失偏颇，这对我们选用工具和切入点是很关键的。本节的标题虽然是 WebRTC 源码下载与编译，但在这之前，我们有必要大概地了解 WebRTC，比如开发机构、免费性、支持的平台、功能亮点。

WebRTC 是一个免费开源的跨平台项目，由 Google，Mozilla，Opera 等支持，支持 Chrome，Firefox，Opera 以及 Android 和 iOS 平台，能够给浏览器、手机应用和物联网设备提供了实时互动能力。

WebRTC 是一组协议和 API。WebRTC 的起源可追溯到 2011年，经过六年多的时间的发展，在 2017年底 WebRTC 1.0 标准正式出炉。通过 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 可以看到现在最新的 release 版本是 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ)。

2015年移动端直播的兴起，观众可以在手机端实时看主播的直播，但是观众与主播之间的沟通需要通过发弹幕来进行，这种交流的实时性较差，沟通不便利，观众参与感较差。2016年初移动端上出现了主播与观众之间可以通过实时视频聊天这种方式来沟通，即，视频连麦。那我们想实现这种视频连麦的功能该怎么做呢？

现在通过 WebRTC 以及其它一些音视频工具，我们就可以搭建一个视频聊天工具，做到视频连麦，也能做到类似于微信视频群聊。关于各种实现视频连麦的方式，这里就不细说了，放到后面的章节来解说。

了解到 WebRTC 是个什么东西后，通常人的心里就会产生一种跃跃欲试的冲动，想试试，那试试就试试呗。“磨刀不误砍柴工”这句话是有道理的，当我们没有经验和没有人传授经验的时候，那我们就要琢磨这句“磨刀不误砍柴工”了。我们要砍柴做饭，找到一把刀拿起就跑到树林里去砍柴，结果发现刀太钝，砍柴真费劲。这个时候，我们就意识到砍柴刀要用磨刀石磨一磨，磨锋利了，就能提升砍柴的效率。我举这个例子，就想说明两点：

<!-- more -->

第一，先尝试可以加深理解，获取自己的经验。

第二，通过获取的经验，重新调整，比如调整做事步骤，加深理论学习等。

WebRTC 支持 Windows, Mac OS X, Linux, Android 和 iOS 平台，这里以 iOS 平台为例来描述 WebRTC 的源码下载和编译过程。

> # 选择 Release 版本

## step 1

从 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 的 release 版本中选择最新的版本，当前最新版为 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ) 

```
WebRTC M74 Release Notes

WebRTC M74 branch (cut at r26981)

Summary

WebRTC M74, currently available in Chrome's beta channel and as native libraries for Android and iOS, contains feature additions like RID/MID based Simulcast, multiple bug fixes, enhancements and stability/performance improvements. As with previous releases, we encourage all developers to run versions of Chrome on the Canary, Dev, and Beta channels frequently and quickly report any issues found. Please take a look at this page, for some pointers on how to file a good bug report. The help we have received has been invaluable! 

The Chrome release schedule can be found here. Native libraries for Android and iOS are built on a weekly basis and are available on JCenter and CocoaPods; the Changelog is available here.
```

## step 2

进入分支 [WebRTC M74 branch](https://chromium.googlesource.com/external/webrtc/+log/branch-heads/m74) (cut at r26981)

```
chromium / external / webrtc / branch-heads/m74

741f9a0 Ignore duplicate sent packets in TransportFeedbackAdapter by Erik Språng · 2 weeks ago

e6d5f62 Merge to M74: Allow setting ALR values for screen content again by Erik Språng · 4 weeks ago

9c745ae Revert "Disable DTLS 1.0, TLS 1.0 and TLS 1.1 downgrade in WebRTC." by Benjamin Wright · 5 weeks ago

1c9bf93 Merge to M74: Fix bug in vp8 FrameDropThreshold by Erik Språng · 5 weeks ago

...

```

## step 3

选择第一条提交记录 [741f9a0 Ignore duplicate sent packets in TransportFeedbackAdapter by Erik Språng · 2 weeks ago] 进入详情页 [chromium / external / webrtc / 741f9a0679bc70682b056004f8421879352d1a8d](https://chromium.googlesource.com/external/webrtc/+/741f9a0679bc70682b056004f8421879352d1a8d)

```
chromium / external / webrtc / 741f9a0679bc70682b056004f8421879352d1a8d

commit	741f9a0679bc70682b056004f8421879352d1a8d	[log] [tgz]
author	Erik Språng <sprang@webrtc.org>	Thu Apr 18 12:28:02 2019
committer	Erik Språng <sprang@webrtc.org>	Fri Apr 19 17:51:34 2019
tree	36ee311fa41a5d60ab98d87273f210ac90ed3fdf
parent	e6d5f62d010d7f6284504af1c7898894851b238c [diff]

Ignore duplicate sent packets in TransportFeedbackAdapter

Bug: webrtc:10564, chromium:954139, webrtc:10509
Change-Id: I617b58ef8cf5858d7a81aaa39884c5cc1ac2af6e
Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133564
Commit-Queue: Erik Språng <sprang@webrtc.org>
Reviewed-by: Sebastian Jansson <srte@webrtc.org>
Cr-Original-Commit-Position: refs/heads/master@{#27689}(cherry picked from commit d50947ab516ec404b100752617fb828d05cf0e3d)
Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133579
Cr-Commit-Position: refs/branch-heads/m74@{#20}
Cr-Branched-From: be7af9399ceb88171bf60b50419ff2dec8184fb9-refs/heads/master@{#26981}

modules/congestion_controller/rtp/BUILD.gn[diff]
modules/congestion_controller/rtp/send_time_history.cc[diff]
modules/congestion_controller/rtp/send_time_history.h[diff]
modules/congestion_controller/rtp/transport_feedback_adapter.cc[diff]
modules/congestion_controller/rtp/transport_feedback_adapter.h[diff]
modules/congestion_controller/rtp/transport_feedback_adapter_unittest.cc[diff]
6 files changed

tree: 36ee311fa41a5d60ab98d87273f210ac90ed3fdf

...

```

获取到该分支的最新提交记录：**commit	741f9a0679bc70682b056004f8421879352d1a8d**。后面下载源码的时候要用到这个 commit 编号。

> # 安装 depot_tools 工具包

下载源码的时候，要用到 depot_tools 工具包，这是 Chromium 官方推荐的工具包，具备下载、同步、编译、上传代码等功能。depot_tools 的详细介绍见 [Using depot_tools](https://www.chromium.org/developers/how-tos/depottools)。depot_tools 包含如下工具包：

```
gclient
gcl
git-cl
svn [只在 Windows 上使用]
drover
cpplint.py
pylint
presubmit_support.py
repo
wtf
weekly
git-gs
zsh-goodies
```

## step 1

获取 depot_tools 源码，在终端执行命令

```
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
```

```
suntongmiandeMacBook-Pro:~ suntongmian$ cd /Users/suntongmian/Documents/develop/webrtc 
suntongmiandeMacBook-Pro:webrtc suntongmian$
suntongmiandeMacBook-Pro:webrtc suntongmian$ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
正克隆到 'depot_tools'...
fatal: unable to access 'https://chromium.googlesource.com/chromium/tools/depot_tools.git/': Failed to connect to chromium.googlesource.com port 443: Operation timed out
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

出现 “Failed to connect to chromium.googlesource.com port 443: Operation timed out” 问题，检查是否开了 VPN 服务，网络状况是否良好。

我在 clone 代码的时候，开了 VPN 服务，网络状况也很好，但是就是不能 clone 成功。无奈之下，我就在 GitHub 上 fork 了一份别人上传的最新代码作为替代使用。

在终端执行命令，**git clone https://github.com/depthlove/depot_tools.git**，如果前面的步骤没出错，那么可以忽略下面的这一步。

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ git clone https://github.com/depthlove/depot_tools.git
正克隆到 'depot_tools'...
remote: Enumerating objects: 30936, done.
remote: Counting objects: 100% (30936/30936), done.
remote: Compressing objects: 100% (7615/7615), done.
remote: Total 30936 (delta 23107), reused 30936 (delta 23107), pack-reused 0
接收对象中: 100% (30936/30936), 16.85 MiB | 1.03 MiB/s, 完成.
处理 delta 中: 100% (23107/23107), 完成.
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

## step 2

获取 depot_tools 文件夹所在的目录，在终端执行命令 

```
pwd
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ pwd
/Users/suntongmian/Documents/develop/webrtc
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

## step 3

添加环境变量，命令格式为

```
export PATH=$PATH:/path/depot_tools
```

其中，path 为上一步通过 pwd 命令获取的 depot_tools 文件夹所在目录

在终端执行如下命令

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ export PATH=$PATH:/Users/suntongmian/Documents/develop/webrtc/depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

## step 4

到此，depot_tools 的配置已经完成。想知道 depot_tools 是否成功安装，在终端执行命令

```
fetch --help
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ fetch --help
usage: fetch.py [options] <config> [--property=value [--property2=value2 ...]]

This script can be used to download the Chromium sources. See
http://www.chromium.org/developers/how-tos/get-the-code
for full usage instructions.

Valid options:
   -h, --help, help   Print this message.
   --nohooks          Don't run hooks after checkout.
   --force            (dangerous) Don't look for existing .gclient file.
   -n, --dry-run      Don't run commands, only print them.
   --no-history       Perform shallow clones, don't fetch the full git history.

Valid fetch configs:
  android
  android_internal
  breakpad
  chromium
  config_util
  crashpad
  dart
  depot_tools
  goma_client
  gyp
  infra
  infra_internal
  inspector_protocol
  ios
  ios_internal
  nacl
  naclports
  node-ci
  pdfium
  skia
  skia_buildbot
  syzygy
  v8
  webrtc
  webrtc_android
  webrtc_ios
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

打印上面的信息，说明 depot_tools 工具包已经成功安装。

## step 5

想查看 depot_tools 源码的来源信息，可以执行命令

```
gclient --help
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ gclient --help
Your copy of depot_tools is configured to fetch from an obsolete URL:

  https://github.com/depthlove/depot_tools.git

OK to update it to https://chromium.googlesource.com/chromium/tools/depot_tools.git ? [Y/n]
```

[https://github.com/depthlove/depot_tools.git](https://github.com/depthlove/depot_tools.git) 就是前面的步骤中从 GitHub 上获取的 depot_tools。我并不想更新 depot_tools，此处直接输入 n，如果命令结束不了，直接用 ctrl + c 强行终止。


> # 下载源码

WebRTC 文件量较大，在下载之前，磁盘的剩余可用容量要满足：

Linux: 6.4 GB.
Linux (with Android): 16 GB (of which ~8 GB is Android SDK+NDK images).
Mac (with iOS support): 5.6GB

我使用的是 MacBook Pro 2015款机器：

```
macOS Mojave
版本 10.14.4

MacBook Pro (Retina, 13-inch, Early 2015)
处理器 2.7 GHz Intel Core i5
内存 8 GB 1867 MHz DDR3
启动磁盘 Macintosh HD
图形卡 Intel Iris Graphics 6100 1536 MB
磁盘空间 128 GB
可用磁盘空间 17.11 GB
```

我的 Mac 电脑可用磁盘空间 17.11 GB，是足以装的下 5.6 GB 文件的，好了，接下来就可以放心下载源码了。

在终端执行命令

```
fetch --nohooks webrtc_ios
gclient sync -r 741f9a0679bc70682b056004f8421879352d1a8d
```

在 “安装 depot_tools 工具包” 的步骤中，通过 **fetch --help**，可以看到代码目录 webrtc，webrtc_android，webrtc_ios 等。我要在 iOS 平台上使用，就选择了 webrtc_ios。选择依据见 [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/) 中提到的 “This will fetch a regular WebRTC checkout with the iOS-specific parts added.”

741f9a0679bc70682b056004f8421879352d1a8d 是 “选择 Release 版本” 步骤中获取的 M74 Release 版本的 commit 编号信息。


> # 执行编译

编译的方式有2种选择，即使用 ninja 和 Xcode，详见 [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/)。

> # 参考文献

[1] [WebRTC Home](https://webrtc.org/)

[2] [WebRTC becomes design-complete strengthening the Web Platform as a solid actor in the telecommunications arena](https://www.w3.org/2017/11/media-advisory-webrtc10-cr.html.en)

[3] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/2017/CR-webrtc-20171102/), W3C Candidate Recommendation 02 November 2017

[4] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/webrtc/), W3C Candidate Recommendation 27 September 2018

[5] [WebRTC Release Notes](https://webrtc.org/release-notes/) 

[6] [WebRTC Native Code, Development](https://webrtc.org/native-code/development/)

[7] [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/)

[8] [Using depot_tools](https://www.chromium.org/developers/how-tos/depottools)

[9] [depot_tools_tutorial(7) Manual Page](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html)

