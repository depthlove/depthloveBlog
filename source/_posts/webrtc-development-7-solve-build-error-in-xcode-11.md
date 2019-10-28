---
title: WebRTC 开发（七）升级 Xcode 11 后 AppRTCMobile 编译报错的解决方案
date: 2019-10-28 13:11:50
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

将 Xcode 升级到 Xcode 11.1 版本后，工程 AppRTCMobile 编译报错 "code object is not signed at all"。详细信息如下：

```
Showing Recent Messages
CodeSign /Users/suntongmian/Documents/workplace/webrtc/src/out/mac/AppRTCMobile.app (in target 'AppRTCMobile' from project 'products')
    cd /Users/suntongmian/Documents/workplace/webrtc/src/out/mac
    export CODESIGN_ALLOCATE=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/codesign_allocate
    
Signing Identity:     "-"

    /usr/bin/codesign --force --sign - --entitlements /Users/suntongmian/Library/Developer/Xcode/DerivedData/all-cnckbsrgoylvrsaprwpepbkuujvx/Build/Intermediates.noindex/products.build/mac/AppRTCMobile.build/AppRTCMobile.app.xcent --timestamp=none /Users/suntongmian/Documents/workplace/webrtc/src/out/mac/AppRTCMobile.app

/Users/suntongmian/Documents/workplace/webrtc/src/out/mac/AppRTCMobile.app: code object is not signed at all
In subcomponent: /Users/suntongmian/Documents/workplace/webrtc/src/out/mac/AppRTCMobile.app/Contents/Frameworks/WebRTC.framework
Command CodeSign failed with a nonzero exit code
```

<!-- more -->

![build-error-info](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-7-solve-build-error-in-xcode-11/build-error-info.png)

解决方案是：

(1) 选择 target `AppRTCMobile`

(2) 点击 `Build Settings`

(3) 修改 `Signing` 一栏下的 `Other Code Signing Flags`，增加 `--deep`

(4) 修改后，先 clean 下工程，再次执行编译，可以看到编译通过。

如下图所示：

![before-modify-signing](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-7-solve-build-error-in-xcode-11/before-modify-signing.png)

![after-modify-signing](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-7-solve-build-error-in-xcode-11/after-modify-signing.png)

![build-success](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-7-solve-build-error-in-xcode-11/build-success.png)
