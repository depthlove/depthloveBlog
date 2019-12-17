---
title: WebRTC 开发（九）音频采集与渲染
date: 2019-12-17 19:10:01
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

本文讲解下 Mac 端的音频采集和渲染逻辑。

> ### 代码位置

代码位置：webrtc/src/modules/audio_device/mac

```
audio_device_mac.h                     audio_device_mac.cc
audio_mixer_manager_mac.h         audio_mixer_manager_mac.cc
```

