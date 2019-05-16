---
title: WebRTC 开发（二）源码下载与编译
date: 2019-05-02 13:35:17
tags:
- WebRTC
- 音视频处理
categories:
- WebRTC
---

在使用任何工具之前，我们都有必要对工具做大概地的了解，做到粗犷但不失偏颇，这对我们选择工具和切入点是很关键的。本节的标题虽然是 WebRTC 源码下载与编译，但在这之前，我们有必要大概地了解 WebRTC，比如开发机构、免费性、支持的平台、功能亮点。

WebRTC 是一个免费开源的跨平台项目，由 Google，Mozilla，Opera 等支持，支持 Chrome，Firefox，Opera 以及 Android 和 iOS 平台，能够给浏览器、手机应用和物联网设备提供了实时互动能力。

WebRTC 是一组协议和 API。WebRTC 的起源可追溯到 2011年，经过六年多的时间的发展，在 2017年底 WebRTC 1.0 标准正式出炉。通过 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 可以看到现在最新的 release 版本是 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ)。

2015年移动端直播的兴起，观众可以在手机端实时看主播的直播，但是观众与主播之间的沟通需要通过发弹幕来进行，这种交流的实时性较差，沟通不便利，观众参与感较差。2016年初移动端上出现了主播与观众之间可以通过实时视频聊天这种方式来沟通，即，视频连麦。那我们想实现这种视频连麦的功能该怎么做呢？

现在通过 WebRTC 以及其它一些音视频工具，我们就可以搭建一个视频聊天工具，做到视频连麦，也能做到类似于微信视频群聊。关于各种实现视频连麦的方式，这里就不细说了，放到后面的章节来解说。

了解到 WebRTC 是个什么东西后，通常人的心里就会产生一种跃跃欲试的冲动，想试试，那试试就试试呗。“磨刀不误砍柴工”这句话是有道理的，当我们没有经验和没有人传授经验的时候，那我们就要琢磨这句“磨刀不误砍柴工”了。我们要砍柴做饭，找到一把刀拿起就跑到树林里去砍柴，结果发现刀太钝，砍柴真费劲。这个时候，我们就意识到砍柴刀要用磨刀石磨一磨，磨锋利了，就能提升砍柴的效率。我举这个例子，就想说明两点：

<!-- more -->

第一，先尝试可以加深理解，获取自己的经验。

第二，通过获取的经验，重新调整，比如调整做事步骤，加深理论学习等。

WebRTC 支持 Windows, Mac OS X, Linux, Android 和 iOS 平台，这里以 iOS 平台为例来描述 WebRTC 的源码下载和编译过程。

> # 一、安装 depot_tools 工具包

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

depot_tools 源码属于 Google 的服务，即墙外资源，在获取 depot_tools 源码前，先需要开启 VPN 服务，然后在终端执行命令

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

**出现 “Failed to connect to chromium.googlesource.com port 443: Operation timed out” 问题后，需要检查 VPN 服务是否开启，网络状况是否良好。如果在 VPN 服务开启和网络状况良好的情况下，仍然不能 clone 代码成功，那就需要检查终端能否成功访问墙外的资源。**

我开启了 VPN 服务，网络状况也很好，也能通过 Google 浏览器访问资源，但就是不能 clone depot_tools 源码成功。这个时候，我通过命令 **curl** 来检查终端是否具备翻墙功能。

首先，在终端执行命令 

```
curl www.baidu.com
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ curl www.baidu.com
<!DOCTYPE html>
<!--STATUS OK--><html> <head><meta http-equiv=content-type content=text/html;charset=utf-8><meta http-equiv=X-UA-Compatible content=IE=Edge><meta content=always name=referrer><link rel=stylesheet type=text/css href=http://s1.bdstatic.com/r/www/cache/bdorz/baidu.min.css><title>百度一下，你就知道</title></head> <body link=#0000cc> <div id=wrapper> <div id=head> <div 
www.baidu.com/img/gs.gif> </p> </div> </div> </div> </body> </html>
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

可以看到，能很快获取到 www.baidu.com 的资源。说明网络是正常的。

其次，在终端执行命令

```
curl www.google.com
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ curl www.google.com
curl: (7) Failed to connect to www.google.com port 80: Operation timed out
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

可以看到，出现了请求超时的问题。说明通过终端不能访问 Google 服务。那该怎么解决呢？

我的 MacBook 电脑上使用了 ShadowsocksX 客户端来启动 VPN 服务，但只支持浏览器能使用 VPN 服务。我参考了 [MAC 终端走代理服务器](https://blog.csdn.net/jiajiayouba/article/details/81453398) 一文中提到的方法来解决这个问题。

我的 ShadowsocksX 客户端中 Socks5 配置信息如下

```
本地Socks5监听地址：127.0.0.1
本地Socks5监听端口：10808
连接超时：60
```

通过 Socks5 的配置信息，在终端中执行命令

```
export http_proxy=socks5://127.0.0.1:10808
export https_proxy=socks5://127.0.0.1:10808
export all_proxy=socks5://127.0.0.1:10808
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ export http_proxy=socks5://127.0.0.1:10808
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ export https_proxy=socks5://127.0.0.1:10808
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ export all_proxy=socks5://127.0.0.1:10808
suntongmiandeMacBook-Pro:~ suntongmian$ 
```

**提示：执行后，只对当前终端起作用。重启终端后，默认失效。**

启动了终端代理，然后再次执行命令

```
curl www.google.com
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ curl www.google.com
<!doctype html><html itemscope="" itemtype="http://schema.org/WebPage" lang="en"><head><meta content="Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for." name="description"><meta content="noodp" name="robots"><meta content="text/html; charset=UTF-8" http-equiv="Content-Type"><meta content="/logos/doodles/2019/us-teacher-appreciation-week-2019-begins-4994791740801024-l.png" itemprop="image"><meta content="Happy US Teacher Appreciation Week 2019!" property="twitter:title"><meta content="Happy US Teacher Appreciation Week 2019! #GoogleDoodle" 
\u003E\x22,\x22psrl\x22:\x22Remove\x22,\x22sbit\x22:\x22Search by image\x22,\x22srch\x22:\x22Google Search\x22},\x22ovr\x22:{},\x22pq\x22:\x22\x22,\x22refpd\x22:true,\x22rfs\x22:[],\x22sbpl\x22:24,\x22sbpr\x22:24,\x22scd\x22:10,\x22sce\x22:5,\x22stok\x22:\x22s4ND7ehgr2lcHpcv5T93UySs4ho\x22,\x22uhde\x22:false}}';google.pmc=JSON.parse(pmc);})();</script>        </body></html>suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

发现可以正常访问 www.google.com 的资源了。

解决了终端的代理问题后，再次执行命令

```
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
正克隆到 'depot_tools'...
remote: Sending approximately 24.21 MiB ...
remote: Total 31833 (delta 22312), reused 31833 (delta 22312)
接收对象中: 100% (31833/31833), 24.21 MiB | 1.25 MiB/s, 完成.
处理 delta 中: 100% (22312/22312), 完成.
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$
```

到此，可以看到 depot_tools 源码已经下载成功了。

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

其中，path 为上一步通过 pwd 命令获取的 depot_tools 文件夹所在目录。

在终端执行命令

```
export PATH=$PATH:/Users/suntongmian/Documents/develop/webrtc/depot_tools
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ export PATH=$PATH:/Users/suntongmian/Documents/develop/webrtc/depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

**提示：执行后，只对当前终端起作用。重启终端后，默认失效。**

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

打印上面的信息，说明 depot_tools 工具包已经成功安装。接下来就可以通过 depot_tools 工具下载 WebRTC 源码了。

> # 二、下载 WebRTC 源码

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

## step 1

下载所需要的工程，在终端执行命令

```
fetch --nohooks webrtc_ios
```

在 “安装 depot_tools 工具包” 的步骤中，通过 **fetch --help**，可以看到代码目录 webrtc，webrtc_android，webrtc_ios 等。我要在 iOS 平台上使用，就选择了 webrtc_ios。选择依据见 [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/) 中提到的 “This will fetch a regular WebRTC checkout with the iOS-specific parts added.”

这条命令执行时，要下载的文件比较多，需要耐心等待命令的执行结果。

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
'
Running: gclient sync --nohooks --with_branch_heads

________ running 'git -c core.deltaBaseCacheLimit=2g clone --no-checkout --progress https://webrtc.googlesource.com/src.git /Users/suntongmian/Documents/develop/webrtc/_gclient_src_twA2Fg' in '/Users/suntongmian/Documents/develop/webrtc'
Cloning into '/Users/suntongmian/Documents/develop/webrtc/_gclient_src_twA2Fg'...
remote: Sending approximately 253.71 MiB ...        
remote: Counting objects: 22, done        
remote: Finding sources: 100% (22/22)           
Receiving objects:  57% (183907/320504), 74.04 MiB | 1.88 MiB/s    
[0:01:00] Still working on:
[0:01:00]   src
Receiving objects:  60% (192303/320504), 88.48 MiB | 1.35 MiB/s   
[0:01:10] Still working on:
[0:01:10]   src

...

[2:03:36] Still working on:
[2:03:36]   src/third_party/icu

[2:03:46] Still working on:
[2:03:46]   src/third_party/icu

[2:03:52] Still working on:
[2:03:52]   src/third_party/icu
Syncing projects: 100% (38/38), done.                              
Running: git submodule foreach 'git config -f $toplevel/.git/config submodule.$name.ignore all'
Running: git config --add remote.origin.fetch '+refs/tags/*:refs/tags/*'
Running: git config diff.ignoreSubmodules all
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

## step 2

与远端 repo 进行代码同步，在终端执行命令

```
gclient sync
```

这条命令执行时，要下载的文件比较多，需要耐心等待命令的执行结果。

```
suntongmiandeMacBook-Pro:src suntongmian$ gclient sync
Syncing projects: 100% (38/38), done.                                           

________ running '/usr/bin/python src/build/mac_toolchain.py' in '/Users/suntongmian/Documents/develop/webrtc'
Skipping Mac toolchain installation for mac

________ running '/usr/bin/python src/tools/clang/scripts/update.py' in '/Users/suntongmian/Documents/develop/webrtc'
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz 
<urlopen error [Errno 54] Connection reset by peer>
Retrying in 5 s ...
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz Traceback (most recent call last):
  File "src/tools/clang/scripts/update.py", line 322, in <module>
    sys.exit(main())
  File "src/tools/clang/scripts/update.py", line 318, in main
    return UpdateClang()
  File "src/tools/clang/scripts/update.py", line 252, in UpdateClang
    DownloadAndUnpackClangPackage(sys.platform, LLVM_BUILD_DIR)
  File "src/tools/clang/scripts/update.py", line 171, in DownloadAndUnpackClangPackage
    DownloadAndUnpack(cds_full_url, output_dir, path_prefix)
  File "src/tools/clang/scripts/update.py", line 141, in DownloadAndUnpack
    DownloadUrl(url, f)
  File "src/tools/clang/scripts/update.py", line 100, in DownloadUrl
    response = urllib.urlopen(url)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 154, in urlopen
    return opener.open(url, data, timeout)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 431, in open
    response = self._open(req, data)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 449, in _open
    '_open', req)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 409, in _call_chain
    result = func(*args)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 1240, in https_open
    context=self._context)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/urllib2.py", line 1194, in do_open
    h.request(req.get_method(), req.get_selector(), req.data, headers)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 1053, in request
    self._send_request(method, url, body, headers)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 1093, in _send_request
    self.endheaders(body)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 1049, in endheaders
    self._send_output(message_body)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 893, in _send_output
    self.send(msg)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 855, in send
    self.connect()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 1266, in connect
    HTTPConnection.connect(self)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 835, in connect
    self._tunnel()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 812, in _tunnel
    (version, code, message) = response._read_status()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/httplib.py", line 417, in _read_status
    raise BadStatusLine(line)
httplib.BadStatusLine: ''
Error: Command '/usr/bin/python src/tools/clang/scripts/update.py' returned non-zero exit status 1 in /Users/suntongmian/Documents/develop/webrtc
suntongmiandeMacBook-Pro:src suntongmian$ 
```

**出现了错误 “Error: Command '/usr/bin/python src/tools/clang/scripts/update.py'”，暂时不用管，继续后续的步骤。**

执行结果中的 `src/tools/clang/scripts/update.py`, [https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz](https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz) 后面的步骤会用到。

> # 三、执行编译

在执行编译前，我们需要配置好编译的参数和环境，生产出构建文件。这里就需要用到 [GN](https://gn.googlesource.com/gn/+/master/README.md) 这个工具了。GN 是一个为 Ninja 生成构建文件的元构建系统。[Ninja](https://ninja-build.org/) 是一个小型构建系统，特点是构建速度快。

## step 1

使用 GN 来生产 Ninja 工程文件，在终端执行命令

```
gn gen out/ios --args='target_os="ios" target_cpu="arm64" is_debug=true'
```

```
suntongmiandeMacBook-Pro:src suntongmian$ gn gen out/ios --args='target_os="ios" target_cpu="arm64" is_debug=true'
Warning: Multiple codesigning identities match "iPhone Developer"
Warning: - D78B0B7AF39CEFA4D0F673B4D3AA517D312C97CC (selected)
Warning: - 5634EAED50D1AD95ED76F6AC8298E06590FE476B
Warning: - 2843CD233EB6A93C79C2332E4F4FC601BEDA13BC
Warning: Please use either ios_code_signing_identity or 
Warning: ios_code_signing_identity_description variable to 
Warning: control which identity is selected.

Done. Made 1378 targets from 189 files in 2200ms
suntongmiandeMacBook-Pro:src suntongmian$  
```

产生的工程文件在目录 **/src/out/ios** 下。通过命令查看下改目录下有哪些文件，在终端执行命令

```
ls out/ios
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ls out/ios
args.gn
build.ninja
build.ninja.d
clang_x64
low_bandwidth_audio_perf_test.runtime_deps
obj
toolchain.ninja
suntongmiandeMacBook-Pro:src suntongmian$ 
```

## step 2

编译 APP 工程，在终端执行命令

```
ninja -C out/ios AppRTCMobile
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ninja -C out/ios AppRTCMobile
ninja: Entering directory `out/ios'
[1/2732] CXX obj/api/audio_codecs/audio_codecs_api/audio_codec_pair_id.o
FAILED: obj/api/audio_codecs/audio_codecs_api/audio_codec_pair_id.o 
../../third_party/llvm-build/Release+Asserts/bin/clang++ -MMD -MF obj/api/audio_codecs/audio_codecs_api/
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory

...

/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory

...

isystem../../buildtools/third_party/libc++abi/trunk/include -fvisibility-inlines-hidden -Wnon-virtual-dtor -Woverloaded-virtual -c ../../api/audio_codecs/ilbc/audio_encoder_ilbc.cc -o obj/api/audio_codecs/ilbc/audio_encoder_ilbc/audio_encoder_ilbc.o
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory
ninja: build stopped: subcommand failed.
suntongmiandeMacBook-Pro:src suntongmian$ 
```

出现错误 “/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory”。原因是 `/src/third_party/llvm-build` 目录下找不到可执行文件 clang++。

先查看 `/src/third_party/llvm-build` 目录下的文件，在终端执行命令

```
ls third_party/llvm-build
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ls third_party/llvm-build
cr_build_revision
suntongmiandeMacBook-Pro:src suntongmian$
```

发现确实没有可执行文件 `clang++`。 那就手动下载文件包，放置到对应的目录下。根据 **“二、下载 WebRTC 源码”** 的 **step 2** 命令执行结果中提到的的下载地址 [https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz](https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz)，在终端执行命令

```
curl https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz -o third_party/llvm-build/clang.tgz
```

```
suntongmiandeMacBook-Pro:src suntongmian$ curl https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-359912-2.tgz -o third_party/llvm-build/clang.tgz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 27.9M  100 27.9M    0     0  1167k      0  0:00:24  0:00:24 --:--:-- 1469k
suntongmiandeMacBook-Pro:src suntongmian$
```

将下载的 clang.tgz 压缩包解压并根据报错信息重命名为 `Release+Asserts`，在终端执行命令

```
ls third_party/llvm-build
mkdir third_party/llvm-build/Release+Asserts
tar zxvf third_party/llvm-build/clang.tgz -C third_party/llvm-build/Release+Asserts
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ls third_party/llvm-build
clang.tgz	cr_build_revision
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ mkdir third_party/llvm-build/Release+Asserts
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ tar zxvf third_party/llvm-build/clang.tgz -C third_party/llvm-build/Release+Asserts
x bin/
x bin/clang
x bin/clang++
x bin/clang-cl

...

x include/c++/v1/ios
x include/c++/v1/iosfwd
x include/c++/v1/iostream

...

x include/c++/v1/support/android/
x include/c++/v1/support/android/locale_bionic.h

...

x include/c++/v1/version
x include/c++/v1/wchar.h
x include/c++/v1/wctype.h
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls third_party/llvm-build/Release+Asserts/
bin		buildlog.txt	include		lib
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls third_party/llvm-build/Release+Asserts/bin
clang		clang-cl	llvm-symbolizer
clang++		llvm-pdbutil	llvm-undname
suntongmiandeMacBook-Pro:src suntongmian$ 
```

**为什么要将下载的 clang.tgz 压缩包解压并根据报错信息重命名为 `Release+Asserts`？** 这是依据 **“二、下载 WebRTC 源码”** 的 **step 2** 命令执行结果中提到的信息 `src/tools/clang/scripts/update.py`，在终端执行命令查看该脚本的信息

```
cat tools/clang/scripts/update.py
```

```
suntongmiandeMacBook-Pro:src suntongmian$ cat tools/clang/scripts/update.py
#!/usr/bin/env python
# Copyright (c) 2012 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""This script is used to download prebuilt clang binaries. It runs as a
"gclient hook" in Chromium checkouts.

It can also be run stand-alone as a convenient way of installing a well-tested
near-tip-of-tree clang version:

  $ curl -s https://raw.githubusercontent.com/chromium/chromium/master/tools/clang/scripts/update.py | python - --clang-dir=.
"""

# TODO: Running stand-alone won't work on Windows due to the dia dll copying.

from __future__ import print_function

... 

try:
  import urllib2 as urllib
except ImportError: # For Py3 compatibility
  import urllib.request as urllib
  import urllib.error as urllib

import zipfile


# Do NOT CHANGE this if you don't know what you're doing -- see
# https://chromium.googlesource.com/chromium/src/+/master/docs/updating_clang.md
# Reverting problematic clang rolls is safe, though.
CLANG_REVISION = '359912'
CLANG_SUB_REVISION = 2

PACKAGE_VERSION = '%s-%s' % (CLANG_REVISION, CLANG_SUB_REVISION)
RELEASE_VERSION = '9.0.0'

CDS_URL = os.environ.get('CDS_CLANG_BUCKET_OVERRIDE',
    'https://commondatastorage.googleapis.com/chromium-browser-clang')

# Path constants. (All of these should be absolute paths.)
THIS_DIR = os.path.abspath(os.path.dirname(__file__))
CHROMIUM_DIR = os.path.abspath(os.path.join(THIS_DIR, '..', '..', '..'))
LLVM_BUILD_DIR = os.path.join(CHROMIUM_DIR, 'third_party', 'llvm-build',
                              'Release+Asserts')

STAMP_FILE = os.path.normpath(
    os.path.join(LLVM_BUILD_DIR, '..', 'cr_build_revision'))
FORCE_HEAD_REVISION_FILE = os.path.normpath(os.path.join(LLVM_BUILD_DIR, '..',
                                                   'force_head_revision'))



def DownloadUrl(url, output_file):
  """Download url into output_file."""
  CHUNK_SIZE = 4096
  TOTAL_DOTS = 10
  num_retries = 3
  retry_wait_s = 5  # Doubled at each retry.

  while True:
    try:
      sys.stdout.write('Downloading %s ' % url)
      sys.stdout.flush()
      response = urllib.urlopen(url)
      total_size = int(response.info().getheader('Content-Length').strip())
      bytes_done = 0
      dots_printed = 0     
      
...

    except urllib.URLError as e:
      sys.stdout.write('\n')
      print(e)
      if num_retries == 0 or isinstance(e, urllib.HTTPError) and e.code == 404:
        raise e
      num_retries -= 1
      print('Retrying in %d s ...' % retry_wait_s)

...

def DownloadAndUnpack(url, output_dir, path_prefix=None):
  """Download an archive from url and extract into output_dir. If path_prefix 

def DownloadAndUnpackClangPackage(platform, output_dir, runtimes_only=False):
  cds_file = "clang-%s.tgz" %  PACKAGE_VERSION

...

def UpdateClang():
  GCLIENT_CONFIG = os.path.join(os.path.dirname(CHROMIUM_DIR), '.gclient')

...

  DownloadAndUnpackClangPackage(sys.platform, LLVM_BUILD_DIR)

...

  if args.llvm_force_head_revision:
    print('--llvm-force-head-revision can only be used for --print-revision')
    return 1

  if args.clang_dir:
    global LLVM_BUILD_DIR, STAMP_FILE
    LLVM_BUILD_DIR = os.path.abspath(args.clang_dir)
    STAMP_FILE = os.path.join(LLVM_BUILD_DIR, 'cr_build_revision')

  return UpdateClang()


if __name__ == '__main__':
  sys.exit(main())
suntongmiandeMacBook-Pro:src suntongmian$ 
```

从该脚本的注释信息 `This script is used to download prebuilt clang binaries` 可以得知该脚本作用就是下载 `clang` 可执行文件。其中 `clang` 的版本信息为 `CLANG_REVISION = '359912' CLANG_SUB_REVISION = 2 RELEASE_VERSION = '9.0.0'`，`llvm-build` 的目录信息为 `LLVM_BUILD_DIR = os.path.join(CHROMIUM_DIR, 'third_party', 'llvm-build', 'Release+Asserts')`。

再次在终端执行命令 

```
ninja -C out/ios AppRTCMobile
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ninja -C out/ios AppRTCMobile
ninja: Entering directory `out/ios'
[2735/2736] CODE SIGNING //examples:Ap...//build/toolchain/mac:ios_clang_arm64)
FAILED: AppRTCMobile.app/AppRTCMobile AppRTCMobile.app/_CodeSignature/CodeResources AppRTCMobile.app/embedded.mobileprovision AppRTCMobile.app/Info.plist 
python ../../build/config/ios/codesign.py code-sign-bundle -t=iphoneos -i=D78B0B7AF39CEFA4D0F673B4D3AA517D312C97CC -b=obj/examples/AppRTCMobile -e=../../build/config/ios/entitlements.plist AppRTCMobile.app -P=../../build/config/mac/plist_util.py -p=gen/examples/AppRTCMobile_generate_info_plist.plist -p=gen/examples/AppRTCMobile_partial_info.plist
Error: no mobile provisioning profile found for "com.google.AppRTCMobile".
ninja: build stopped: subcommand failed.
suntongmiandeMacBook-Pro:src suntongmian$ 
```

至此，编译 APP 的过程结束了。虽然出现了 “Error: no mobile provisioning profile found for "com.google.AppRTCMobile".” 的报错，但这并不是太重要，我只关心编译过程的其它环节正确无误。这个 Error 信息表示 APP 的包名 "com.google.AppRTCMobile" 没有与之对应的苹果开发者证书的配置文件，将该 APP 安装到手机上后，会因证书配置文件的问题无法使用。这个问题很好解决，就是改 APP 的包名，在编译的时候选择对应的苹果开发者证书的配置文件后，重新编译就行了。

进入目录 `/src/out/ios` 可以看下编译后产生了哪些文件。在终端执行命令

```
ls out/ios
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ls out/ios
AppRTCMobile.app
WebRTC.framework
args.gn
build.ninja
build.ninja.d
clang_x64
gen
low_bandwidth_audio_perf_test.runtime_deps
obj
pyproto
toolchain.ninja
suntongmiandeMacBook-Pro:src suntongmian$ 
```

在这一步，其实可以得到我想要的 WebRTC 库文件了，即 `WebRTC.framework`。

## step 3

虽然上一步，在编译 WebRTC 的演示 APP 时，可以得到 `WebRTC.framework` 库文件，但这不是正常获取库文件的路子。编译 WebRTC 库文件的方法有2种，分别为 ninja 命令行，python 脚本。

### 方法 1

使用 `ninja` 命令行编译，在终端执行命令

```
ninja -C out/ios framework_objc
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ninja -C out/ios framework_objc
ninja: Entering directory `out/ios'
ninja: no work to do.
suntongmiandeMacBook-Pro:src suntongmian$
```

可以看到 “ninja: no work to do.”，为什么会提示这条信息呢？原因在于上一步骤中已经编译产生了 `WebRTC.framework` 库文件。如果想看看只编译库文件的过程，那可以不执行上一步骤中编译 APP 的环节，即不执行命令 `ninja -C out/ios AppRTCMobile`，现在的情况是我们已经执行了该条命令，那直接删掉已经存在的 `WebRTC.framework` 库文件就行了。在终端执行命令

```
rm -rf out/ios/WebRTC.framework
```

```
suntongmiandeMacBook-Pro:src suntongmian$ rm -rf out/ios/WebRTC.framework
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls out/ios
AppRTCMobile.app
args.gn
build.ninja
build.ninja.d
clang_x64
gen
low_bandwidth_audio_perf_test.runtime_deps
obj
pyproto
toolchain.ninja
suntongmiandeMacBook-Pro:src suntongmian$ 
```

再次在终端执行命令

```
ninja -C out/ios framework_objc
```

```
suntongmiandeMacBook-Pro:src suntongmian$ ninja -C out/ios framework_objc
ninja: Entering directory `out/ios'
[97/97] STAMP obj/sdk/framework_objc.stamp
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls out/ios
AppRTCMobile.app
WebRTC.framework
args.gn
build.ninja
build.ninja.d
clang_x64
gen
low_bandwidth_audio_perf_test.runtime_deps
obj
pyproto
toolchain.ninja
suntongmiandeMacBook-Pro:src suntongmian$ 
```

生成的 `WebRTC.framework` 库文件在 `out/ios` 目录下。

### 方法 2

使用 python 脚本 `/src/tools_webrtc/ios/build_ios_libs.py` 编译，在终端执行命令

```
python tools_webrtc/ios/build_ios_libs.py --bitcode
```

```
suntongmiandeMacBook-Pro:src suntongmian$ python tools_webrtc/ios/build_ios_libs.py --bitcode
INFO:root:Building WebRTC with args: target_os="ios" ios_enable_code_signing=false use_xcode_clang=true is_component_build=false is_debug=false target_cpu="arm64" ios_deployment_target="10.0" rtc_libvpx_build_vp9=false enable_ios_bitcode=true use_goma=false enable_stripping=true
Done. Made 1376 targets from 189 files in 1727ms
INFO:root:Building target: framework_objc
ninja: Entering directory `/Users/suntongmian/Documents/develop/webrtc/src/out_ios_libs/arm64_libs'
[2614/2614] STAMP obj/sdk/framework_objc.stamp
INFO:root:Building WebRTC with args: target_os="ios" ios_enable_code_signing=false use_xcode_clang=true is_component_build=false is_debug=false target_cpu="arm" ios_deployment_target="10.0" rtc_libvpx_build_vp9=false enable_ios_bitcode=true use_goma=false enable_stripping=true
Done. Made 1377 targets from 189 files in 1953ms
INFO:root:Building target: framework_objc
ninja: Entering directory `/Users/suntongmian/Documents/develop/webrtc/src/out_ios_libs/arm_libs'
[2656/2656] STAMP obj/sdk/framework_objc.stamp
INFO:root:Building WebRTC with args: target_os="ios" ios_enable_code_signing=false use_xcode_clang=true is_component_build=false is_debug=false target_cpu="x64" ios_deployment_target="10.0" rtc_libvpx_build_vp9=false enable_ios_bitcode=true use_goma=false enable_stripping=true
Done. Made 1402 targets from 192 files in 5101ms
INFO:root:Building target: framework_objc
ninja: Entering directory `/Users/suntongmian/Documents/develop/webrtc/src/out_ios_libs/x64_libs'
[2777/2777] STAMP obj/sdk/framework_objc.stamp
INFO:root:Building WebRTC with args: target_os="ios" ios_enable_code_signing=false use_xcode_clang=true is_component_build=false is_debug=false target_cpu="x86" ios_deployment_target="10.0" rtc_libvpx_build_vp9=false enable_ios_bitcode=true use_goma=false enable_stripping=true
Done. Made 1402 targets from 192 files in 1754ms
INFO:root:Building target: framework_objc
ninja: Entering directory `/Users/suntongmian/Documents/develop/webrtc/src/out_ios_libs/x86_libs'
[2771/2771] STAMP obj/sdk/framework_objc.stamp
INFO:root:Merging framework slices.
INFO:root:Done.
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls out_ios_libs
WebRTC.framework	arm_libs		x86_libs
arm64_libs		x64_libs
suntongmiandeMacBook-Pro:src suntongmian$ 
```

生成的库文件在 `out_ios_lib` 目录下。脚本 `tools_webrtc/ios/build_ios_libs.py` 默认编译的架构是 `DEFAULT_ARCHS = ENABLED_ARCHS = ['arm64', 'arm', 'x64', 'x86']`，编译出来的库为动态库。查看库支持的架构，以及是静态库还是动态库，在终端执行命令

```
lipo -info out_ios_libs/WebRTC.framework/WebRTC
file out_ios_libs/arm64_libs/WebRTC.framework/WebRTC
```

```
suntongmiandeMacBook-Pro:src suntongmian$ lipo -info out_ios_libs/WebRTC.framework/WebRTC
Architectures in the fat file: out_ios_libs/WebRTC.framework/WebRTC are: x86_64 i386 armv7 arm64 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ file out_ios_libs/WebRTC.framework/WebRTC
out_ios_libs/WebRTC.framework/WebRTC: Mach-O universal binary with 4 architectures: [x86_64:Mach-O 64-bit dynamically linked shared library x86_64] [arm64]
out_ios_libs/WebRTC.framework/WebRTC (for architecture x86_64):	Mach-O 64-bit dynamically linked shared library x86_64
out_ios_libs/WebRTC.framework/WebRTC (for architecture i386):	Mach-O dynamically linked shared library i386
out_ios_libs/WebRTC.framework/WebRTC (for architecture armv7):	Mach-O dynamically linked shared library arm_v7
out_ios_libs/WebRTC.framework/WebRTC (for architecture arm64):	Mach-O 64-bit dynamically linked shared library arm64
suntongmiandeMacBook-Pro:src suntongmian$ 
```

**提示：使用了动态库的 APP 在上架 APP Store 时，会报错不支持模拟器架构 `['x64', 'x86']`，所以，需要剔除动态库中的模拟器架构，只使用真机架构 ['arm64', 'arm']。**

可以修改脚本 `tools_webrtc/ios/build_ios_libs.py` 中的参数，将编译的架构改成 `DEFAULT_ARCHS = ENABLED_ARCHS = ['arm64']`。为什么去掉了 arm？因为现在人们使用的苹果设备几乎都是 arm64 架构了，arm 架构的苹果设备几乎绝迹，去掉 arm，也可以减轻 WebRTC 库的体积。

> # 四、总结

编译 WebRTC 库的步骤就那么几步，但实际我们在编译的过程中会遇到各种各样的问题，看似简单的事情变得很是折磨人。出现问题并不可怕，根据报错的信息，耐心仔细检查、搜集资料、寻求帮助、反复尝试，是可以解决问题的。解决问题的过程中，切忌浮躁，没有一个平稳的心态，事情会变得一波多折。

本文篇幅很长，详细记录了每一步操作，可以方便自己以后回顾，也能给看该文的同行一些启发。为方便浏览，总结编译步骤如下：

第一步：安装 depot_tools，配置环境变量

```
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:/Users/suntongmian/Documents/develop/webrtc/depot_tools
```

第二步：下载 WebRTC 源码

```
fetch --nohooks webrtc_ios
gclient sync
```

第三步：编译 WebRTC

方法 1

```
gn gen out/ios --args='target_os="ios" target_cpu="arm64" is_debug=true'
ninja -C out/ios framework_objc
```

方法 2

```
gn gen out/ios --args='target_os="ios" target_cpu="arm64" is_debug=true'
python tools_webrtc/ios/build_ios_libs.py --bitcode
```

> # 参考文献

[1] [WebRTC Home](https://webrtc.org/)

[2] [WebRTC becomes design-complete strengthening the Web Platform as a solid actor in the telecommunications arena](https://www.w3.org/2017/11/media-advisory-webrtc10-cr.html.en)

[3] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/2017/CR-webrtc-20171102/), W3C Candidate Recommendation 02 November 2017

[4] [WebRTC 1.0: Real-time Communication Between Browsers](https://www.w3.org/TR/webrtc/), W3C Candidate Recommendation 27 September 2018

[5] [WebRTC SRC](https://webrtc.googlesource.com/src)

[6] [WebRTC Release Notes](https://webrtc.org/release-notes/) 

[7] [WebRTC Native Code, Development](https://webrtc.org/native-code/development/)

[8] [WebRTC Native Code, iOS](https://webrtc.org/native-code/ios/)

[9] [Using depot_tools](https://www.chromium.org/developers/how-tos/depottools)

[10] [depot_tools_tutorial(7) Manual Page](https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html)

[11] [MAC 终端走代理服务器](https://blog.csdn.net/jiajiayouba/article/details/81453398)

[12] [让终端走代理的几种方法](https://blog.fazero.me/2015/09/15/%E8%AE%A9%E7%BB%88%E7%AB%AF%E8%B5%B0%E4%BB%A3%E7%90%86%E7%9A%84%E5%87%A0%E7%A7%8D%E6%96%B9%E6%B3%95/)

[13] [GN](https://gn.googlesource.com/gn/+/master/README.md)

[14] [Ninja](https://ninja-build.org/)

[15] [chromium中的GN构建系统](https://blog.csdn.net/mogoweb/article/details/73650218)

[16] [Chromium GN构建工具的使用](https://www.wolfcstech.com/2016/11/16/ChromiumGN%E6%9E%84%E5%BB%BA%E5%B7%A5%E5%85%B7%E7%9A%84%E4%BD%BF%E7%94%A8/)

[17] [【Git学习笔记】Git冲突：commit your changes or stash them before you can merge.](https://blog.csdn.net/liuchunming033/article/details/45368237)

[18] [Download a file with curl on Linux / Unix command line](https://www.cyberciti.biz/faq/download-a-file-with-curl-on-linux-unix-command-line/)