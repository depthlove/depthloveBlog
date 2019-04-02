---
title: 深度学习项目移植之使用 cmake 编译 iOS 平台库
date: 2017-05-21 08:38:53
tags:
- 工作
- iOS
- 深度学习
---

去年（2016年）做深度学习项目的移动端移植用到了 cmake，现在把当时写的一篇使用流程贴出来，主要目的是备忘。废话不多说，直接进入正题。

## 1. 下载 X11 并安装

关于 Mac 版 X11，Mac 不再随附 X11，但 XQuartz 项目会提供 X11 服务器和客户端库。XQuartz 项目提供适用于 MacOS 的 X11 服务器和客户端库，网址是 [https://www.xquartz.org](https://www.xquartz.org)。下载可用的最新版本并安装。具体说明见：[关于 Mac 版 X11](https://support.apple.com/zh-cn/HT201341)

## 2. 下载 cmake 的 dmg 格式并安装

下载地址: [https://cmake.org/download/](https://cmake.org/download/)，本文使用的是 Mac OSX 10.6 or later，cmake-3.7.1-Darwin-x86_64.dmg 版本。

## 3. 终端安装 cmake
在终端执行命令：

	sudo "/Applications/CMake.app/Contents/bin/cmake-gui" --install
	
<!-- more -->

## 4. 进入包含 CMakeLists.txt 文件的源码文件夹 xxx 并执行命令得到 Mac 工程（注意：命令的空格）

在终端依次执行下面的命令：***（备注：xxx 为工程的名称）***

	cd xxx
    
	mkdir build
    
	cd build
    
	cmake -G Xcode ..

## 5. 将 Mac 工程改为 iOS 工程
(1) 进入 build 文件夹，打开 Project.xcodeproj 工程，Duplicate TARGET "xxx"，生成了1个新的 TARGET "xxx copy" ***（备注：xxx 为 TARGET 的名称，跟 章节 4 中的 xxx 是同名的，也就是说章节 3 中的 xxx 决定了此处 Xcode 项目的 TARGET 名称）***
    
(2) 将 TARGET "xxx copy" 改名为 "xxx-iOS"
    
(3) 进入 TARGET "xxx-iOS" 的 Build Settings，将 Architectures 下的 Base SDK 改为 Latest iOS(iOS 10.2)，此时 Architectures，Supported Platforms，Valid Architectures 都会变成跟 iOS 平台相关的设置
    
(4) 修改 iOS Deployment Target 为想要支持的最低版本，此处设置支持的 iOS 最低版本为 iOS 7.0
    
(5) 在 Xcode 的左上角选择工程 xxx copy，接着进入 Manage Schemes，将 xxx copy 更名为 xxx-iOS

## 6. 编译 xxx-iOS 即可得到 iOS 静态库 libxxx-iOS.a

## 7. 终端执行命令 lipo -info libxxx-iOS.a 查看 iOS 静态库支持的 Architectures （如：armv7，arm64，x86_64，i386）

在终端执行命令：

	lipo -info libxxx-iOS.a

输出结果为

Architectures in the fat file: libxxx-iOS.a are: armv7 arm64

若要生成 x86_64，i386 模拟器架构，就需要在使用 Xcode 编译的时候编译相应的 x86_64，i386 库。
	
	


