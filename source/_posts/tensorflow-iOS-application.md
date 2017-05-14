---
title: tensorflow 在 iOS 平台上的应用
date: 2017-01-16 13:08:35
tags:
- iOS中高级开发
- 深度学习DL
---

Google 开源的深度学习框架 tensorflow 成为2016年最受欢迎的深度学习框架之一。tensorflow 除了支持 pc 端外，还较好的支持了 android，iOS 移动端平台。移动端作为现在互联网的终端主宰，tensorflow 毫无疑问地会引起移动互联网行业的广泛关注。深度学习在2016年的火爆，以及移动终端的主宰地位，作为程序员的我们，不玩玩 tensorflow  简直就 out 了。

### 1. fork Github 上的 tensorflow repo
tensorflow 的仓库 repo 位于 Github 上，我们作为开发者要在其基础上做开发，首先就需要 fork 一份 repo 到自己的 Github 账户下。

### 2. 参考 tensorflow 的官方使用文档编译（使用 tensorflow r1.0 版本）
参考[tensorflow 的官方使用文档](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/contrib/makefile/README.md)编译 iOS 平台上的 tensorflow 库。

<!-- more -->

**_Note: To use this library in an iOS application, see related instructions in
the [iOS examples](../ios_examples/) directory._**

Install XCode 7.3 or more recent. If you have not already, you will need to
install the command-line tools using `xcode-select`:

```bash
xcode-select --install
```

If this is a new install, you will need to run XCode once to agree to the
license before continuing.

Then install [automake](https://en.wikipedia.org/wiki/Automake)/[libtool](https://en.wikipedia.org/wiki/GNU_Libtool):

```bash
brew install automake
brew install libtool
```

Also, download the graph if you haven't already:

```bash
mkdir -p ~/graphs
curl -o ~/graphs/inception.zip \
 https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip \
 && unzip ~/graphs/inception.zip -d ~/graphs/inception
```

**_Note: Building all at once._**

If you just want to get the libraries compiled in a hurry, you can run this
from the root of your TensorFlow source folder:

```bash
tensorflow/contrib/makefile/build_all_ios.sh
```

This process will take around twenty minutes on a modern MacBook Pro.

When it completes, you will have a library for a single architecture and the
benchmark program. Although successfully compiling the benchmark program is a
sign of success, the program is not a complete iOS app.

To see TensorFlow running on iOS, the example Xcode project in
[tensorflow/contrib/ios_examples](../ios_examples) shows how to use the static
library in a simple app.

我使用的 Xcode 版本如下

![Xcode 版本](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116142514333-1602060782.png)

我的 Mac Pro 设备参数如下，执行脚本 tensorflow/contrib/makefile/build_all_ios.sh 编译 iOS 平台的 tensorflow 库`花费了90分钟`。

![Mac Pro 设备参数](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116134659802-716920306.png)

![开始编译时的截图](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116135708880-1402615710.png)

![编译完成时的截图](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116140108661-2089552430.png)

libtensorflow-core.a 所在的路径和支持的 CPU 架构 armv7，armv7s，i386，x86_64，arm64 如下：

![](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116181935786-829505024.png)

![](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116181959052-862893730.png)

### 3. 打开 tensorflow/contrib/ios_examples 下的 Xcode 工程
#### 3.1 tf_ios_makefile_example.xcodeproj
进入 /tensorflow/tensorflow/contrib/ios_examples/simple 文件夹打开工程 tf_ios_makefile_example.xcodeproj 运行 run

![tf_ios_makefile_example.xcodeproj 运行出现的错误](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116143445255-1618884987.png)

参考[TensorFlow iOS Examples 文档](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/contrib/ios_examples/README.md) 加载 iOS demo 工程所需要的数据模型，需要操作的命令如下

```bash
mkdir -p ~/graphs
curl -o ~/graphs/inception5h.zip \
 https://storage.googleapis.com/download.tensorflow.org/models/inception5h.zip \
 && unzip ~/graphs/inception5h.zip -d ~/graphs/inception5h
cp ~/graphs/inception5h/* tensorflow/contrib/ios_examples/benchmark/data/
cp ~/graphs/inception5h/* tensorflow/contrib/ios_examples/camera/data/
cp ~/graphs/inception5h/* tensorflow/contrib/ios_examples/simple/data/
```

具体操作：先进入 tensorflow 的根目录，然后依次执行上面的命令。

![运行 ios examples 要执行的命令](http://images2015.cnblogs.com/blog/719115/201701/719115-20170116150401130-1501991403.png)

此时，在 Xcode 中 clean（快捷键是 command + shift + k） 下 tf_ios_makefile_example.xcodeproj 工程。运行 run（快捷键是 command + r），success 后 iOS 设备出现的界面和点击按钮 Run Model 后的界面如下图所示：

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170116150927114-514982468.png" width="250" height="445" />

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170116152640786-773711415.png" width="250" height="445" />

#### 3.2 camera_example.xcodeproj 可以识别出物体

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170116161341255-1424145846.png" width="250" height="445" />

#### 3.3 benchmark.xcodeproj

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170116161942833-341355774.png" width="250" height="445" />

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170116161955317-1079763651.png" width="250" height="445" />

