---
title: macOS 系统上 Android Studio 配置 Flutter 开发环境
date: 2019-12-19 21:15:19
tags:
- Flutter
categories:
- Flutter
---

废话不多说，直接上步骤。

# 下载 Flutter SDK

在终端执行命令：

```
cd /Users/suntongmian/Documents/workplace

git clone -b v1.13.2 git@github.com:flutter/flutter.git flutter

```

# 配置环境变量

配置环境变量前，需要获知电脑默认使用的 shell 类型，在终端执行命令：

```
echo $SHELL
```

<!-- more -->

根据终端的输出，在对应的文件中配置环境变量。

(1) .bash shell 需编辑文件 ~/.bash_profile，在终端执行命令并添加配置：

```
vi ~/.bash_profile
```

加入环境变量

```
export flutter_sdk_path=/Users/suntongmian/Documents/workplace/flutter
export PATH=$flutter_sdk_path/bin:$PATH
```

执行下面的命令让配置生效

```
source ~/.bash_profile
```

(2) .zsh shell 需编辑文件 ~/.zshrc

```
vi ~/.zshrc
```

加入环境变量

```
export flutter_sdk_path=/Users/suntongmian/Documents/workplace/flutter
export PATH=$flutter_sdk_path/bin:$PATH
```

执行下面的命令让配置生效

```
source ~/.zshrc
```

# 执行命令 flutter precache

在终端执行命令：

```
cd flutter

flutter precache
```

# 执行命令 flutter doctor

在终端继续执行命令：

```
flutter doctor
```

若执行结果中出现警告：

```
[!] Xcode - develop for iOS and macOS (Xcode 11.2)
    ✗ CocoaPods installed but not initialized.
        CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on
        the Dart side.
        Without CocoaPods, plugins will not work on iOS or macOS.
        For more info, see https://flutter.dev/platform-plugins
      To initialize CocoaPods, run:
        pod setup
      once to finalize CocoaPods' installation.
```

解决方法为卸载当前的 cocoapods，重新安装 cocoapods 1.7.5 版本。命令执行如下：

```
sudo gem uninstall cocoapods

sudo gem install cocoapods -v 1.7.5

pod setup
```

执行完上面的操作后，再次执行命令 `flutter doctor` 检测是否有其它插件的安装警告。

# 检测默认使用的 Flutter 版本

在终端执行命令：

```
which flutter
```

执行结果为：**/Users/suntongmian/Documents/workplace/flutter/bin/flutter**，符合预期。


# 新建 Flutter 项目

打开 Android Studio，在启动界面看到 “Start a new Flutter project” 一项，就说明 Flutter 配置生效了。新建一个 Flutter 工程。就可以在  `Android Studio -> Preferences... -> Languages & Frameworks` 看使用的  Flutter，Dart 的 SDK 是哪个版本。

# 更换 Flutter / Dart SDK

如果想切换到某个团队维护的 Flutter SDK，那么，就需要将前面的步骤重新来一遍。最后到 `Android Studio -> Preferences... -> Languages & Frameworks` 配置 Flutter，Dart 的 SDK 的路径。

**备注**：所有的步骤包括新建一个工程并打开这个工程，如果不打开一个 Flutter 工程，那么在 `Android Studio -> Preferences... -> Languages & Frameworks`  看不到  Flutter，Dart  配置选项。

# 参考文献

[1] [https://flutter.dev/docs/get-started/install/macos](https://flutter.dev/docs/get-started/install/macos)

[2] [https://github.com/flutter/flutter](https://github.com/flutter/flutter)

[3] [CocoaPods installed but not initialised #41291](https://github.com/flutter/flutter/issues/41291)
