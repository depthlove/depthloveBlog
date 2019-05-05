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

> # 选择版本

从 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 的 release 版本中选择最新的版本，当前最新版为 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ) 

```
WebRTC M74 Release Notes

WebRTC M74 branch (cut at r26981)

Summary

WebRTC M74, currently available in Chrome's beta channel and as native libraries for Android and iOS, contains feature additions like RID/MID based Simulcast, multiple bug fixes, enhancements and stability/performance improvements. As with previous releases, we encourage all developers to run versions of Chrome on the Canary, Dev, and Beta channels frequently and quickly report any issues found. Please take a look at this page, for some pointers on how to file a good bug report. The help we have received has been invaluable! 

The Chrome release schedule can be found here. Native libraries for Android and iOS are built on a weekly basis and are available on JCenter and CocoaPods; the Changelog is available here.
```

进入分支 [WebRTC M74 branch](https://chromium.googlesource.com/external/webrtc/+log/branch-heads/m74) (cut at r26981)

```
chromium / external / webrtc / branch-heads/m74

741f9a0 Ignore duplicate sent packets in TransportFeedbackAdapter by Erik Språng · 2 weeks ago

e6d5f62 Merge to M74: Allow setting ALR values for screen content again by Erik Språng · 4 weeks ago

9c745ae Revert "Disable DTLS 1.0, TLS 1.0 and TLS 1.1 downgrade in WebRTC." by Benjamin Wright · 5 weeks ago

1c9bf93 Merge to M74: Fix bug in vp8 FrameDropThreshold by Erik Språng · 5 weeks ago

...

```

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

> # 下载源码

下载源码的时候，要用到 gclient 工具，该工具具备类似于 git clone 的作用，可以将远程分支的代码克隆到本地。为什么不直接用 git 工具的 git clone 呢？原因在于 Google 的代码管理工具用的就是 gclient，用来管理源码的 checkout, update 等。此处，我们知道 gclient 是个什么东西就行了，要想详细了解可以自行 Google。

我使用的是 MacBook Pro 2015款机器：

```
macOS Mojave
版本 10.14.4

MacBook Pro (Retina, 13-inch, Early 2015)
处理器 2.7 GHz Intel Core i5
内存 8 GB 1867 MHz DDR3
启动磁盘 Macintosh HD
图形卡 Intel Iris Graphics 6100 1536 MB
```





> # 执行编译




> # 参考文献

[1] [WebRTC Home](https://webrtc.org/)

[2] [WebRTC becomes design-complete strengthening the Web Platform as a solid actor in the telecommunications arena](https://www.w3.org/2017/11/media-advisory-webrtc10-cr.html.en)

[3] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/2017/CR-webrtc-20171102/), W3C Candidate Recommendation 02 November 2017

[4] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/webrtc/), W3C Candidate Recommendation 27 September 2018

[5] [WebRTC Release Notes](https://webrtc.org/release-notes/) 

[6] [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/)

[7] [gclient](https://www.chromium.org/developers/how-tos/depottools)

