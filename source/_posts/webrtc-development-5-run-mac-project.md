---
title: WebRTC 开发（五）编译与运行 Mac 工程
date: 2019-10-18 14:52:36
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

在 [WebRTC 开发（四）源码下载与更新](http://depthlove.github.io/2019/10/18/webrtc-development-4-source-code-download-and-update/) 一文中，我们获取到了可以在 iOS，macOS 平台运行的 WebRTC 源码。其中，在执行命令 `fetch --nohooks webrtc_ios` 时，我们可以明确看到代码支持的平台 **ios, mac**。

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ fetch --nohooks webrtc_ios
Running: gclient root
WARNING: Your metrics.cfg file was invalid or nonexistent. A new one will be created.
Running: gclient config --spec 'solutions = [
  {
    "url": "https://webrtc.googlesource.com/src.git",
    "managed": False,
    "name": "src",
    "deps_file": "DEPS",
    "custom_deps": {},
  },
]
target_os = ["ios", "mac"]
```

以前，我的精力一直放在 iOS 平台的项目开发上，现在主要投入 Mac 平台的项目开发，所以，对 Mac 项目的关注度更大一些。下面的编译也以 Mac 为切入点。

WebRTC 的编译可以使用 `ninja`，也可以使用 `Xcode`。本文采用 Xcode 来编译 WebRTC 的 Mac 工程。

<!-- more -->

> ### 编译 WebRTC 的 Mac 工程

> #### 命令

```
cd /Users/suntongmian/Documents/workplace 

ls

cd webrtc

ls

cd src

ls

ls examples

ls examples/objc

ls examples/objc/AppRTCMobile

gn gen out/mac --ide=xcode

# 查看 ~/.bashrc 文件中是否配置有工具 depot_tools 的路径
cat ~/.bashrc
export PATH=$PATH:/Users/suntongmian/Documents/workplace/webrtc/depot_tools

# 启动 gn 工具
source ~/.bashrc

gn gen out/mac --ide=xcode

ls out/mac

# 启动 Xcode 工程
open -a Xcode.app out/mac/all.xcworkspace

```

> #### 命令执行过程


```
Last login: Fri Oct 18 20:59:20 on ttys000

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ cd /Users/suntongmian/Documents/workplace 
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ ls
webrtc
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ cd webrtc/
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools	src
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ cd src/
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls
AUTHORS			README.chromium		buildtools		ios			presubmit_test.py	style-guide.md		webrtc
BUILD.gn		README.md		call			license_template.txt	presubmit_test_mocks.py	system_wrappers		webrtc.gni
CODE_OF_CONDUCT.md	WATCHLISTS		chromium		logging			pylintrc		talk			whitespace.txt
DEPS			abseil-in-webrtc.md	codereview.settings	media			resources		test
ENG_REVIEW_OWNERS	api			common_audio		modules			rtc_base		testing
LICENSE			audio			common_types.h		native-api.md		rtc_tools		third_party
OWNERS			base			common_video		out			sdk			tools
PATENTS			build			data			p2p			stats			tools_webrtc
PRESUBMIT.py		build_overrides		examples		pc			style-guide		video
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls examples/
BUILD.gn		aarproject		androidnativeapi	objcnativeapi		stunprober		unityplugin
DEPS			androidapp		androidtests		peerconnection		stunserver
OWNERS			androidjunit		objc			relayserver		turnserver
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls examples/objc
AppRTCMobile	Icon-120.png	Icon-180.png	Icon.png	README
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls examples/objc/AppRTCMobile/
ARDAppClient+Internal.h		ARDExternalSampleCapturer.h	ARDSettingsModel+Private.h	ARDStatsBuilder.m		RTCIceServer+JSON.m
ARDAppClient.h			ARDExternalSampleCapturer.m	ARDSettingsModel.h		ARDTURNClient+Internal.h	RTCSessionDescription+JSON.h
ARDAppClient.m			ARDJoinResponse+Internal.h	ARDSettingsModel.m		ARDTURNClient.h			RTCSessionDescription+JSON.m
ARDAppEngineClient.h		ARDJoinResponse.h		ARDSettingsStore.h		ARDTURNClient.m			common
ARDAppEngineClient.m		ARDJoinResponse.m		ARDSettingsStore.m		ARDWebSocketChannel.h		ios
ARDBitrateTracker.h		ARDMessageResponse+Internal.h	ARDSignalingChannel.h		ARDWebSocketChannel.m		mac
ARDBitrateTracker.m		ARDMessageResponse.h		ARDSignalingMessage.h		RTCIceCandidate+JSON.h		tests
ARDCaptureController.h		ARDMessageResponse.m		ARDSignalingMessage.m		RTCIceCandidate+JSON.m		third_party
ARDCaptureController.m		ARDRoomServerClient.h		ARDStatsBuilder.h		RTCIceServer+JSON.h
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$ gn gen out/mac --ide=xcode
-bash: gn: command not found
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ cat ~/.bashrc
export PATH=$PATH:/Users/suntongmian/Documents/workplace/webrtc/depot_tools
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ source ~/.bashrc
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ gn gen out/mac --ide=xcode
Generating Xcode projects took 200ms
Done. Made 1056 targets from 206 files in 2007ms
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls out/mac/
AppRTCMobile.app				genmacro					products.xcodeproj
WebRTC.framework				genmodule					protoc
all.xcworkspace					genperf						pyproto
args.gn						genstring					re2c
build.ninja					genversion					toolchain.ninja
build.ninja.d					low_bandwidth_audio_perf_test.runtime_deps	yasm
gen						obj
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$ open -a Xcode.app out/mac/all.xcworkspace
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
```

> #### 在 Xcode 中执行 target 的编译和运行

选择 target "AppRTCMobile"，执行 Run 操作，运行成功后就可以看到弹出的 Mac 端应用界面。

![webrtc-mac-project](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-5-run-mac-project/webrtc-mac-project.png)

> ### 参考文献

[1] [https://webrtc.org/native-code/ios/](https://webrtc.org/native-code/ios/)