---
title: WebRTC 开发（二）源码下载与编译
date: 2019-05-02 13:35:17
tags:
- WebRTC
- 音视频处理
---

在使用任何工具之前，我们都有必要对工具做大概地的了解，做到粗犷但不失偏颇，这对我们选用工具和切入点是很关键的。本节的标题虽然是 WebRTC 源码下载与编译，但在这之前，我们有必要大概地了解 WebRTC，比如开发机构、免费性、支持的平台、功能亮点。

WebRTC 是一个免费开源的跨平台项目，由 Google，Mozilla，Opera 等支持，支持 Chrome，Firefox，Opera 以及 Android 和 iOS 平台，能够给浏览器、手机应用和物联网设备提供了实时互动能力。

WebRTC 是一组协议和 API。WebRTC 的起源可追溯到 2011年，经过六年多的时间的发展，在 2017年底 WebRTC 1.0 标准正式出炉。通过 WebRTC 的 [release notes](https://webrtc.org/release-notes/) 可以看到现在最新的 release 版本是 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ)。

2015年移动端直播的兴起，观众可以在手机端实时看主播的直播，但是观众与主播之间的沟通需要通过发弹幕来进行，这种交流的实时性较差，沟通不便利，观众参与感较差。2016年初移动端上出现了主播与观众之间可以通过实时视频聊天这种方式来沟通，即，视频连麦。那我们想实现这种视频连麦的功能该怎么做呢？

现在通过 WebRTC 以及其它一些音视频工具，我们就可以搭建一个视频聊天工具，做到视频连麦，也能做到类似于微信视频群聊。关于各种实现视频连麦的方式，这里就不细说了，放到后面的章节来解说。

了解到 WebRTC 是个什么东西后，通常人的心里就会产生一种跃跃欲试的冲动，想试试，那试试就试试呗。“磨刀不误砍柴工”这句话是有道理的，当我们没有经验和没有人传授经验的时候，那我们就要琢磨这句“磨刀不误砍柴工”了。我们要砍柴做饭，找到一把刀拿起就跑到树林里去砍柴，结果发现刀太钝，砍柴真费劲。这个时候，我们就意识到砍柴刀要用磨刀石磨一磨，磨锋利了，就能提升砍柴的效率。我举这个例子，就想说明两点：

<!-- more -->

第一，先尝试可以加深理解，获取自己的经验。

第二，通过获取的经验，重新调整，比如调整做事步骤，加深理论学习等。

参考文献：

[1] [WebRTC Home](https://webrtc.org/)

[2] [WebRTC becomes design-complete strengthening the Web Platform as a solid actor in the telecommunications arena](https://www.w3.org/2017/11/media-advisory-webrtc10-cr.html.en)

[3] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/2017/CR-webrtc-20171102/), W3C Candidate Recommendation 02 November 2017

[4] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/webrtc/), W3C Candidate Recommendation 27 September 2018

