---
title: WebRTC 开发（十）编译与运行 iOS 工程
date: 2019-12-31 14:20:13
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

在 [WebRTC 开发（五）编译与运行 Mac 工程](https://depthlove.github.io/2019/10/18/webrtc-development-5-run-mac-project/) 一文中，介绍了如何运行 Mac 工程，可以参考其流程，来运行 iOS 工程，将 WebRTC 应用安装到 iOS 设备上。

> ### 编译 WebRTC 的 iOS 工程

> #### 进入 WebRTC 源码目录

```
cd /Users/suntongmian/Documents/workplace 

cd webrtc/src
```

> #### 修改 iOS 应用的 Info.plist 文件

为什么要修改 Info.plist 文件？原因是运行 iOS 应用，应用的 bundle id 和 iOS 证书要匹配。

编辑 `examples/objc/AppRTCMobile/ios/Info.plist`

```
vi examples/objc/AppRTCMobile/ios/Info.plist

```

根据 iOS 证书来指定一个可用的 bundle id，替换下面的 `com.google.AppRTCMobile`

```
<key>CFBundleIdentifier</key>
<string>com.google.AppRTCMobile</string>
```

改为

```
<key>CFBundleIdentifier</key>
<string>com.tms.AppRTCMobile</string>
```

<!-- more -->

![modify-info-plist.png](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/modify-info-plist.png)

> #### 配置 depot_tools 工具的路径

查看 ~/.bashrc 文件中是否配置有工具 depot_tools 的路径

```
cat ~/.bashrc
export PATH=$PATH:/Users/suntongmian/Documents/workplace/webrtc/depot_tools
```

启动 gn 工具

```
source ~/.bashrc
```

> #### 创建 iOS 工程

生成 iOS 平台的 Xcode 工程

```
gn gen out/ios --args='target_os="ios" target_cpu="arm64" ios_enable_code_signing=true ios_code_signing_identity="Apple Development: tongmiansun@gmail.com (7XVLGK8W92)"' --ide=xcode
```

执行结果：

```
Generating Xcode projects took 108ms
Done. Made 1357 targets from 190 files in 5167ms
```

启动 Xcode 工程

```
open -a Xcode.app out/ios/all.xcworkspace
```

> #### 配置 iOS 工程

打开 iOS 工程后，需要配置工程的 Info.plist，选择 examples/objc/AppRTCMobile/ios/Info.plist 作为工程的配置文件。

![ios-project.png](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/ios-project.png)

选择 Info.plist 文件

![select-info-plist.png](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/select-info-plist.png)

加载 Info.plist 文件后

![load-info-plist.png](https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/load-info-plist.png)

> #### 运行 iOS 工程

按下 `command + R` 键运行工程，好点的机器耗时5分钟，差一点的机器需要耗时10分钟，就可以将 WebRTC APP 安装到 iOS 设备上了。

工程编译时间长短跟 Mac 设备性能有关系，性能强的 Mac 设备编译速度快很多，如果你的设备耗时 10分钟以上了，说明你要换 Mac 设备了。

<center class="half">
    <img src="https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/ios-app-home.png" width="400"/>
    <img src="https://raw.githubusercontent.com/depthlove/depthloveBlog/master/source/images/webrtc-development-10-run-ios-project/ios-app-meeting.png" width="400"/>
</center>

> ### 参考文献

[1] [https://webrtc.org/native-code/ios/](https://webrtc.org/native-code/ios/)