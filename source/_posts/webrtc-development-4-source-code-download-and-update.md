---
title: WebRTC 开发（四）源码下载与更新
date: 2019-10-18 11:42:58
tags:
- 音视频处理
- WebRTC
categories:
- WebRTC
---

前文 [WebRTC 开发（二）源码下载与编译](https://depthlove.github.io/2019/05/02/webrtc-development-2-source-code-download-and-build/) 提到了 WebRTC 的下载和编译，但没有提及切换到某个 release 分支去做编译。

看了下博客的文章归档记录，有五个多月没更新音视频相关的文章了。至于是哪些因素影响了，我会在后续的随笔中写写。回归正题，在这五个多月里，WebRTC 更新了一些版本，我们可以通过 [https://webrtc.org/release-notes/](https://webrtc.org/release-notes/) 看下2019年1月到现在，Google 的 WebRTC 的进展。

[M76 Release Notes](https://groups.google.com/forum/#!msg/discuss-webrtc/Y7TIuNbgP8M/UoXP-RuxAwAJ), 2019年7月1日  
 
[M75 Release Notes](https://groups.google.com/forum/#!msg/discuss-webrtc/_jlUbYjv-hQ/mCtjlVyjAgAJ), 2019年5月16日

[M74 Release Notes](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ), 2019年3月27日

[M73 Release Notes](https://groups.google.com/forum/#!msg/discuss-webrtc/l0gc3RjBhc0/FsMqOlOSBwAJ), 2019年2月26日

WebRTC 是个庞大的项目，阅读项目的架构和每个版本的 release notes 是很有必要的。

这里顺带提下 Google 的工程开发日历 [https://chromiumdash.appspot.com/schedule](https://chromiumdash.appspot.com/schedule)，可以了解 Google 项目开发的规划。

代码分支 [https://chromiumdash.appspot.com/branches](https://chromiumdash.appspot.com/branches) 上可以看 Google 浏览器的版本和内置的工具版本，比如 WebRTC

```
Milestone  Chromium   Skia     V8       WebRTC  Pdfium
  79        3945       m79   7.9-lkgr    m79     3945
  78        3904       m78   7.8-lkgr    m78     3904
  77        3865       m77   7.7-lkgr    m77     3865
  76        3809       m76   7.6-lkgr    m76     3809
```

前面松松散散开了个头，接下来的内容就是实际操作 WebRTC 源码的下载、更新、代码分支的切换。最后将分支 `branch-heads/m76` 拉取到了本地，后续的文章将基于 m76 这个版本来做讲解和分析。

通过 `git branch -r ` 可以看到存在 `branch-heads/m79`，但是为什么不用 m79 呢？原因是 m76 是最新的 release 版本，稳定性和可调试性可以得到保证。

<!-- more -->

> ### 源码下载与更新

> #### 命令

```
# 代码下载

cd /Users/suntongmian/Documents/workplace

mkdir -p webrtc

ls

cd webrtc

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

ls

pwd

vi ~/.bashrc

添加 "export PATH=$PATH:/Users/suntongmian/Documents/workplace/webrtc/depot_tools"

cat ~/.bashrc

source ~/.bashrc

fetch --help

fetch --nohooks webrtc_ios

gclient sync

ls -l

ls -a

# 代码更新

cd src

git checkout master

git pull origin master

gclient sync

# 拉取远程分支到本地

git branch

git branch -r

git checkout -b m76 refs/remotes/branch-heads/m76

git branch

git log

# 使用对应分支的工具

cd ..

ls

# 9863f3d246e2da7a2e1f42bbc5757f6af5ec5682 为分支的最近一个 commit 提交

gclient sync -r 9863f3d246e2da7a2e1f42bbc5757f6af5ec5682 --force

```

> #### 命令执行过程

```
Last login: Fri Oct 18 19:02:58 on ttys000

The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ 
suntongmiandeMacBook-Pro:~ suntongmian$ cd /Users/suntongmian/Documents/workplace 
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ mkdir -p webrtc
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ ls
webrtc
suntongmiandeMacBook-Pro:workplace suntongmian$ 
suntongmiandeMacBook-Pro:workplace suntongmian$ cd webrtc/
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
Cloning into 'depot_tools'...
remote: Sending approximately 27.22 MiB ...
remote: Counting objects: 2, done
remote: Finding sources: 100% (2/2)
remote: Total 35324 (delta 24564), reused 35324 (delta 24564)
Receiving objects: 100% (35324/35324), 27.22 MiB | 14.29 MiB/s, done.
Resolving deltas: 100% (24564/24564), done.
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ pwd
/Users/suntongmian/Documents/workplace/webrtc
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ vi ~/.bashrc
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$
suntongmiandeMacBook-Pro:webrtc suntongmian$ cat ~/.bashrc
export PATH=$PATH:/Users/suntongmian/Documents/workplace/webrtc/depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ source ~/.bashrc
suntongmiandeMacBook-Pro:webrtc suntongmian$
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
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
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
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
1>________ running 'git -c core.deltaBaseCacheLimit=2g clone --no-checkout --progress https://webrtc.googlesource.com/src.git /Users/suntongmian/Documents/workplace/webrtc/_gclient_src_DAvF9n' in '/Users/suntongmian/Documents/workplace/webrtc'
1>Cloning into '/Users/suntongmian/Documents/workplace/webrtc/_gclient_src_DAvF9n'...
1>remote: Sending approximately 253.81 MiB ...        
1>remote: Counting objects: 10, done        
1>remote: Finding sources: 100% (10/10)           
1>remote: Total 337917 (delta 257917), reused 337914 (delta 257917)        
1>Receiving objects: 100% (337917/337917), 253.75 MiB | 16.53 MiB/s, done.
1>Resolving deltas: 100% (257917/257917), done.
Syncing projects:  28% (11/38) src/ios                                   
[0:01:48] Still working on:
[0:01:48]   src/third_party
[0:01:48]   src/tools

[0:01:58] Still working on:
[0:01:58]   src/third_party
[0:01:58]   src/tools

[0:02:08] Still working on:
[0:02:08]   src/third_party
[0:02:08]   src/tools

[0:02:18] Still working on:
[0:02:18]   src/third_party
[0:02:18]   src/tools

[0:02:27] Still working on:
[0:02:27]   src/third_party
[0:02:27]   src/tools
Syncing projects:  44% (17/38) src/tools/swarming_client                                  
[0:03:30] Still working on:
[0:03:30]   src/third_party

[0:03:41] Still working on:
[0:03:41]   src/third_party

[0:03:51] Still working on:
[0:03:51]   src/third_party

[0:04:01] Still working on:
[0:04:01]   src/third_party

[0:04:11] Still working on:
[0:04:11]   src/third_party

[0:04:21] Still working on:
[0:04:21]   src/third_party

[0:04:31] Still working on:
[0:04:31]   src/third_party

[0:04:41] Still working on:
[0:04:41]   src/third_party

[0:04:51] Still working on:
[0:04:51]   src/third_party

[0:05:01] Still working on:
[0:05:01]   src/third_party

[0:05:11] Still working on:
[0:05:11]   src/third_party

[0:05:21] Still working on:
[0:05:21]   src/third_party

[0:05:31] Still working on:
[0:05:31]   src/third_party

[0:05:41] Still working on:
[0:05:41]   src/third_party

[0:05:51] Still working on:
[0:05:51]   src/third_party

[0:06:01] Still working on:
[0:06:01]   src/third_party

[0:06:05] Still working on:
[0:06:05]   src/third_party
Syncing projects: 100% (38/38), done.                                  
Running: git submodule foreach 'git config -f $toplevel/.git/config submodule.$name.ignore all'
Running: git config --add remote.origin.fetch '+refs/tags/*:refs/tags/*'
Running: git config diff.ignoreSubmodules all
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ gclient sync
Syncing projects: 100% (38/38), done.                                                     
Running hooks:  45% (10/22) mac_toolchain                 
________ running 'vpython src/build/mac_toolchain.py' in '/Users/suntongmian/Documents/workplace/webrtc'
Skipping Mac toolchain installation for mac
Running hooks:  54% (12/22) clang        
________ running 'vpython src/tools/clang/scripts/update.py' in '/Users/suntongmian/Documents/workplace/webrtc'
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-373424-64a362e7-1.tgz .......... Done.
Running hooks:  68% (15/22) clang_format_mac
________ running 'download_from_google_storage --no_resume --platform=darwin --no_auth --bucket chromium-clang-format -s src/buildtools/mac/clang-format.sha1' in '/Users/suntongmian/Documents/workplace/webrtc'
0> Downloading src/buildtools/mac/clang-format...
Downloading 1 files took 11.863632 second(s)
Hook 'download_from_google_storage --no_resume --platform=darwin --no_auth --bucket chromium-clang-format -s src/buildtools/mac/clang-format.sha1' took 12.38 secs
Running hooks: 100% (22/22)                     
________ running 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' in '/Users/suntongmian/Documents/workplace/webrtc'
3> Downloading src/resources/foreman_480x272.yuv...
4> Downloading src/resources/far8_stereo.pcm...
0> Downloading src/resources/foreman_240x136.yuv...
2> Downloading src/resources/near44_stereo.pcm...
1> Downloading src/resources/ref03.aecdump...
8> Downloading src/resources/speech_and_misc_wb.pcm...
9> Downloading src/resources/foreman_cif.yuv...
6> Downloading src/resources/foreman_320x240.yuv...
7> Downloading src/resources/e2e_audio_in.pcm...
5> Downloading src/resources/far44_stereo.pcm...
3> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

1> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> Downloading src/resources/google-wifi-3mbps.rx...
0> Downloading src/resources/reference_less_video_test_file.y4m...
6> Downloading src/resources/att-uplink.rx...
1> Downloading src/resources/web_screenshot_1850_1110.yuv...
9> Downloading src/resources/foreman_cif_short.yuv...
0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> Downloading src/resources/near48_stereo.pcm...
7> Downloading src/resources/near32_stereo.pcm...
5> Downloading src/resources/near16_stereo.pcm...
2> Downloading src/resources/paris_qcif.yuv...
8> Downloading src/resources/ConferenceMotion_1280_720_50.yuv...
0> Downloading src/resources/foreman_176x144.yuv...
9> Downloading src/resources/foreman_160x120.yuv...
2> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> Downloading src/resources/far32_stereo.pcm...
2> Downloading src/resources/far48_stereo.pcm...
8> Downloading src/resources/short_mixed_stereo_48.pcm...
6> Downloading src/resources/short_mixed_stereo_48.dat...
1> Downloading src/resources/near8_stereo.pcm...
0> Downloading src/resources/far16_stereo.pcm...
9> Downloading src/resources/foremanColorEnhanced_cif_short.yuv...
4> Downloading src/resources/FourPeople_1280x720_30.yuv...
7> Downloading src/resources/short_mixed_mono_48_arm.dat...
5> Downloading src/resources/presentation_1850_1110.yuv...
9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> Downloading src/resources/pc_quality_smoke_test_alice_source.wav...
3> Downloading src/resources/photo_1850_1110.yuv...
4> Downloading src/resources/pc_quality_smoke_test_bob_source.wav...
6> Downloading src/resources/att-downlink.rx...
1> Downloading src/resources/short_mixed_mono_48.dat...
2> Downloading src/resources/difficult_photo_1850_1110.yuv...
8> Downloading src/resources/short_mixed_mono_48.pcm...
0> Downloading src/resources/foreman_128x96.yuv...
7> Downloading src/resources/reference_video_640x360_30fps.y4m...
5> Downloading src/resources/deflicker_before_cif_short.yuv...
7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> Downloading src/resources/images/renderStartImage.jpg...
5> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> Downloading src/resources/images/captureDeviceImage.jpg...
3> Downloading src/resources/images/webrtc_logo.jpg...
1> Downloading src/resources/video_engine/renderStartImage.jpg...
7> Downloading src/resources/images/renderTimeoutImage.jpg...
5> Downloading src/resources/video_engine/renderTimeoutImage.jpg...
6> Downloading src/resources/video_coding/frame-loopback.pcap...
8> Downloading src/resources/video_coding/frame-ethernet-ii.pcap...
2> Downloading src/resources/video_coding/ssrcs-3.pcap...
0> Downloading src/resources/video_coding/pltype103.rtp...
9> Downloading src/resources/video_coding/pltype103_header_only.rtp...
4> Downloading src/resources/video_coding/ssrcs-2.pcap...
3> Downloading src/resources/audio_device/audio_short44.pcm...
7> Downloading src/resources/audio_device/audio_short8.pcm...
1> Downloading src/resources/audio_device/audio_short48.pcm...
5> Downloading src/resources/audio_device/audio_short16.pcm...
6> Downloading src/resources/audio_coding/music_stereo_48kHz.pcm...
8> Downloading src/resources/audio_coding/F01.INP...
2> Downloading src/resources/audio_coding/F00.INP...
0> Downloading src/resources/audio_coding/F03.OUT30...
6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> Downloading src/resources/audio_coding/F01.OUT20...
6> Downloading src/resources/audio_coding/speech_mono_16kHz.pcm...
4> Downloading src/resources/audio_coding/testfile32kHz.pcm...
3> Downloading src/resources/audio_coding/clean.chn...
7> Downloading src/resources/audio_coding/F01.BIT30...
1> Downloading src/resources/audio_coding/neteq_universal_new.rtp...
5> Downloading src/resources/audio_coding/F03.BIT20...
6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> Downloading src/resources/audio_coding/F01.OUT30...
2> Downloading src/resources/audio_coding/F03.OUT20...
0> Downloading src/resources/audio_coding/F03.BIT30...
6> Downloading src/resources/audio_coding/F01.BIT20...
9> Downloading src/resources/audio_coding/testfile_fake_stereo_32kHz.pcm...
4> Downloading src/resources/audio_coding/neteq_opus.rtp...
3> Downloading src/resources/audio_coding/F00.BIT30...
7> Downloading src/resources/audio_coding/F02.BIT20...
5> Downloading src/resources/audio_coding/speech_4_channels_48k_one_second.wav...
1> Downloading src/resources/audio_coding/F02.OUT30...
8> Downloading src/resources/audio_coding/F02.INP...
2> Downloading src/resources/audio_coding/F00.OUT20...
0> Downloading src/resources/audio_coding/F03.INP...
6> Downloading src/resources/audio_coding/neteq_opus_dtx.rtp...
9> Downloading src/resources/audio_coding/speech_mono_32_48kHz.pcm...
3> Downloading src/resources/audio_coding/F02.BIT30...
4> Downloading src/resources/audio_coding/F00.BIT20...
7> Downloading src/resources/audio_coding/teststereo32kHz.pcm...
9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> Downloading src/resources/audio_coding/F00.OUT30...
1> Downloading src/resources/audio_coding/F02.OUT20...
8> Downloading src/resources/audio_processing/output_data_float.pb...
0> Downloading src/resources/audio_processing/output_data_mac.pb...
2> Downloading src/resources/audio_processing/output_data_fixed.pb...
6> Downloading src/resources/audio_processing/conversational_speech/SE_script1_M_sp1_A1.wav...
9> Downloading src/resources/audio_processing/conversational_speech/EN_script1_M_sp1_B1.wav...
3> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_B2.wav...
4> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_A2.wav...
7> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_B3.wav...
5> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_A3.wav...
1> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_B3.wav...
8> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_B2.wav...
2> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_A1.wav...
0> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_B1.wav...
6> Downloading src/resources/audio_processing/conversational_speech/breathing_M_sp1_1.wav...
9> Downloading src/resources/audio_processing/conversational_speech/breathing_F_sp2_2.wav...
3> Downloading src/resources/audio_processing/conversational_speech/SE_script1_F_sp1_A2.wav...
4> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp1_B2.wav...
7> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp2_A1.wav...
2> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_A4.wav...
1> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_B4.wav...
8> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp1_A1.wav...
5> Downloading src/resources/audio_processing/conversational_speech/SE_script1_F_sp1_B1.wav...
0> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp2_B2.wav...
6> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_B4.wav...
9> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_A1.wav...
4> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_A2.wav...
3> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_B2.wav...
7> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_A3.wav...
1> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_B3.wav...
2> Downloading src/resources/audio_processing/conversational_speech/breathing_F_sp1_1.wav...
8> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_A1.wav...
5> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_B1.wav...
0> Downloading src/resources/audio_processing/conversational_speech/SE_script1_M_sp1_B2.wav...
6> Downloading src/resources/audio_processing/conversational_speech/EN_script1_M_sp1_A2.wav...
9> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_B4.wav...
4> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_A4.wav...
3> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp2_A2.wav...
7> Downloading src/resources/audio_processing/conversational_speech/breathing_F_sp2_1.wav...
1> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp1_B1.wav...
8> Downloading src/resources/audio_processing/conversational_speech/SE_script1_F_sp1_A1.wav...
0> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_A4.wav...
2> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_A2.wav...
5> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_B2.wav...
6> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_A3.wav...
9> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_B3.wav...
4> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_B1.wav...
3> Downloading src/resources/audio_processing/conversational_speech/breathing_M_sp1_2.wav...
1> Downloading src/resources/audio_processing/conversational_speech/breathing_M_sp1_3.wav...
7> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_B1.wav...
8> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_A1.wav...
2> Downloading src/resources/audio_processing/conversational_speech/EN_script1_M_sp1_B2.wav...
0> Downloading src/resources/audio_processing/conversational_speech/SE_script1_M_sp1_A2.wav...
5> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_B4.wav...
6> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_A4.wav...
9> Downloading src/resources/audio_processing/conversational_speech/EN_script1_M_sp1_A1.wav...
3> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_B2.wav...
4> Downloading src/resources/audio_processing/conversational_speech/SE_script1_M_sp1_B1.wav...
1> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_A2.wav...
8> Downloading src/resources/audio_processing/conversational_speech/EN_script2_M_sp1_B3.wav...
7> Downloading src/resources/audio_processing/conversational_speech/SE_script2_M_sp1_A3.wav...
5> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_B1.wav...
2> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_A1.wav...
0> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_A3.wav...
9> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp2_A2.wav...
6> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp2_B1.wav...
4> Downloading src/resources/audio_processing/conversational_speech/EN_script1_F_sp1_A2.wav...
3> Downloading src/resources/audio_processing/conversational_speech/SE_script1_F_sp1_B2.wav...
1> Downloading src/resources/audio_processing/conversational_speech/EN_script2_F_sp1_A4.wav...
8> Downloading src/resources/audio_processing/conversational_speech/SE_script2_F_sp1_B4.wav...
7> Downloading src/resources/audio_processing/test/py_quality_assessment/noise_tracks/city.wav...
2> Downloading src/resources/audio_processing/test/py_quality_assessment/probing_signals/tone-880.wav...
9> Downloading src/resources/audio_processing/agc2/rnn_vad/pitch_search_int.dat...
6> Downloading src/resources/audio_processing/agc2/rnn_vad/samples.pcm...
5> Downloading src/resources/audio_processing/agc2/rnn_vad/pitch_lp_res.dat...
0> Downloading src/resources/audio_processing/agc2/rnn_vad/vad_prob.dat...
7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

7> Downloading src/resources/audio_processing/agc2/rnn_vad/band_energies.dat...
4> Downloading src/resources/audio_processing/agc2/rnn_vad/pitch_buf_24k.dat...
3> Downloading src/resources/audio_processing/transient/suppressed8kHz.pcm...
1> Downloading src/resources/audio_processing/transient/double-utils.dat...
8> Downloading src/resources/audio_processing/transient/audio32kHz.pcm...
2> Downloading src/resources/audio_processing/transient/wpd0.dat...
9> Downloading src/resources/audio_processing/transient/detect32kHz.dat...
0> Downloading src/resources/audio_processing/transient/wpd1.dat...
6> Downloading src/resources/audio_processing/transient/detect48kHz.dat...
5> Downloading src/resources/audio_processing/transient/detect16kHz.dat...
7> Downloading src/resources/audio_processing/transient/ajm-macbook-1-spke16m.pcm...
1> Downloading src/resources/audio_processing/transient/wpd7.dat...
3> Downloading src/resources/audio_processing/transient/wpd6.dat...
4> Downloading src/resources/audio_processing/transient/audio48kHz.pcm...
8> Downloading src/resources/audio_processing/transient/audio16kHz.pcm...
9> Downloading src/resources/audio_processing/transient/wpd3.dat...
2> Downloading src/resources/audio_processing/transient/audio8kHz.pcm...
0> Downloading src/resources/audio_processing/transient/wpd2.dat...
6> Downloading src/resources/audio_processing/transient/suppressed32kHz.pcm...
5> Downloading src/resources/audio_processing/transient/detect8kHz.dat...
7> Downloading src/resources/audio_processing/transient/float-utils.dat...
1> Downloading src/resources/audio_processing/transient/suppressed16kHz.pcm...
3> Downloading src/resources/audio_processing/transient/wpd4.dat...
8> Downloading src/resources/audio_processing/transient/wpd5.dat...
4> Downloading src/resources/audio_processing/agc/agc_voicing_prob.dat...
9> Downloading src/resources/audio_processing/agc/agc_with_circular_buffer.dat...
2> Downloading src/resources/audio_processing/agc/agc_spectral_peak.dat...
0> Downloading src/resources/audio_processing/agc/agc_no_circular_buffer.dat...
5> Downloading src/resources/audio_processing/agc/agc_audio.pcm...
6> Downloading src/resources/audio_processing/agc/agc_pitch_lag.dat...
7> Downloading src/resources/audio_processing/agc/agc_pitch_gain.dat...
1> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyDelay_0_AST.bin...
3> Downloading src/resources/audio_processing/agc/agc_vad.dat...
8> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_UnlimitedSpeed_0_AST.bin...
4> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyDelay_0_TOF.bin...
2> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_UnlimitedSpeed_0_TOF.bin...
9> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_Multi1_1_TOF.bin...
0> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingLoss1_0_TOF.bin...
6> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingLoss1_0_AST.bin...
5> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_Multi1_1_AST.bin...
7> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyChoke_1_TOF.bin...
3> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke1_0_TOF.bin...
1> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke1_1_AST.bin...
8> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyChoke_0_AST.bin...
4> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke1_1_TOF.bin...
2> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyChoke_0_TOF.bin...
9> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyChoke_1_AST.bin...
0> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke1_0_AST.bin...
6> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke2_0_TOF.bin...
5> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyLoss_0_TOF.bin...
7> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingDelay1_0_TOF.bin...
3> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke2_1_AST.bin...
1> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke2_1_TOF.bin...
4> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingChoke2_0_AST.bin...
0> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_SteadyLoss_0_AST.bin...
9> Downloading src/resources/network_tester/server_config.dat...
8> Downloading src/resources/network_tester/client_config.dat...
2> Downloading src/resources/remote_bitrate_estimator/VideoSendersTest_BweTest_IncreasingDelay1_0_AST.bin...
6> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR4_2.bin...
5> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR1.bin...
7> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR0.bin...
3> Downloading src/resources/rtp_rtcp/H263Foreman_CIF_Pframe.bin...
1> Downloading src/resources/rtp_rtcp/H263_CIF_IFRAME.bin...
4> Downloading src/resources/rtp_rtcp/H263_QCIF_IFRAME.bin...
0> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR5.bin...
8> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR4.bin...
2> Downloading src/resources/rtp_rtcp/H263Foreman_CIF_Iframe.bin...
9> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR4_1.bin...
6> Downloading src/resources/rtp_rtcp/H263_CIF_PFRAME.bin...
5> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR2.bin...
7> Downloading src/resources/rtp_rtcp/RTCPPacketTMMBR3.bin...
3> Downloading src/resources/voice_engine/audio_dtx16.wav...
1> Downloading src/resources/voice_engine/audio_long16big_endian.pcm...
4> Downloading src/resources/voice_engine/audio_short16.pcm...
0> Downloading src/resources/voice_engine/audio_tiny32.wav...
8> Downloading src/resources/voice_engine/audio_long8.pcm...
2> Downloading src/resources/voice_engine/audio_tiny44.wav...
9> Downloading src/resources/voice_engine/audio_tiny11.wav...
6> Downloading src/resources/voice_engine/audio_long16.wav...
5> Downloading src/resources/voice_engine/audio_long16.pcm...
7> Downloading src/resources/voice_engine/audio_long16noise.pcm...
3> Downloading src/resources/voice_engine/audio_tiny16.wav...
1> Downloading src/resources/voice_engine/audio_tiny22.wav...
4> Downloading src/resources/voice_engine/audio_tiny48.wav...
0> Downloading src/resources/voice_engine/audio_tiny8.wav...
9> Downloading src/resources/voice_engine/audio_long8mulaw.wav...
8> Downloading src/resources/utility/encapsulated_pcm16b_8khz.wav...
2> Downloading src/resources/utility/encapsulated_pcmu_8khz.wav...
6> Downloading src/resources/media/faces_I420.jpg...
5> Downloading src/resources/media/h264-svc-99-640x360.rtpdump...
7> Downloading src/resources/media/faces.1280x720_P420.yuv...
3> Downloading src/resources/media/video.rtpdump...
1> Downloading src/resources/media/captured-320x240-2s-48.frames...
4> Downloading src/resources/media/1.frame_plu/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

s_1.byte...
0> Downloading src/resources/media/faces_I400.jpg...
9> Downloading src/resources/media/faces_I422.jpg...
2> Downloading src/resources/media/voice.rtpdump...
6> Downloading src/resources/media/faces_I444.jpg...
8> Downloading src/resources/media/faces_I411.jpg...
Downloading 263 files took 313.940163 second(s)
Error: Command 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' returned non-zero exit status 1 in /Users/suntongmian/Documents/workplace/webrtc
Hook 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' took 315.89 secs
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls -l
total 0
drwxr-xr-x  211 suntongmian  staff  6752 10 18 19:22 depot_tools
drwxr-xr-x   65 suntongmian  staff  2080 10 18 19:21 src
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls -a
.			.cipd			.gclient_entries	src
..			.gclient		depot_tools
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$
suntongmiandeMacBook-Pro:webrtc suntongmian$ cd src/
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git checkout master
Switched to branch 'master'
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
  (use "git pull" to update your local branch)
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git pull origin master
From https://webrtc.googlesource.com/src
 * branch                  master     -> FETCH_HEAD
Updating 55d19e590d..89e130a2d0
Fast-forward
 api/video/encoded_image.cc            |  9 ---------
 api/video/encoded_image.h             | 14 +-------------
 video/frame_encode_metadata_writer.cc |  2 --
 3 files changed, 1 insertion(+), 24 deletions(-)
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ gclient sync
Syncing projects: 100% (38/38), done.                                                     
Running hooks:  45% (10/22) mac_toolchain                 
________ running 'vpython src/build/mac_toolchain.py' in '/Users/suntongmian/Documents/workplace/webrtc'
Skipping Mac toolchain installation for mac
Running hooks: 100% (22/22)                     
________ running 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' in '/Users/suntongmian/Documents/workplace/webrtc'
/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

2> Downloading src/resources/foreman_480x272.yuv...
0> Downloading src/resources/foreman_240x136.yuv...
7> Downloading src/resources/ref03.aecdump...
4> Downloading src/resources/foreman_320x240.yuv...
9> Downloading src/resources/foreman_cif.yuv...
5> Downloading src/resources/foreman_cif_short.yuv...
3> Downloading src/resources/ConferenceMotion_1280_720_50.yuv...
1> Downloading src/resources/foreman_176x144.yuv...
6> Downloading src/resources/reference_less_video_test_file.y4m...
8> Downloading src/resources/paris_qcif.yuv...
2> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

1> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

2> Downloading src/resources/foreman_160x120.yuv...
0> Downloading src/resources/foremanColorEnhanced_cif_short.yuv...
7> Downloading src/resources/FourPeople_1280x720_30.yuv...
4> Downloading src/resources/deflicker_before_cif_short.yuv...
5> Downloading src/resources/reference_video_640x360_30fps.y4m...
8> Downloading src/resources/audio_coding/speech_mono_32_48kHz.pcm...
6> Downloading src/resources/audio_processing/test/py_quality_assessment/noise_tracks/city.wav...
3> Downloading src/resources/audio_coding/speech_mono_16kHz.pcm...
1> Downloading src/resources/audio_coding/music_stereo_48kHz.pcm...
2> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

1> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

Downloading 263 files took 14.816476 second(s)
Error: Command 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' returned non-zero exit status 1 in /Users/suntongmian/Documents/workplace/webrtc
Hook 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' took 17.06 secs
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch
* master
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch -r
  branch-heads/3.50
  branch-heads/3.51
  branch-heads/3.52
  branch-heads/3.53
  branch-heads/3.54
  branch-heads/3.55
  branch-heads/38
  branch-heads/38p
  branch-heads/39
  branch-heads/39p
  branch-heads/40
  branch-heads/40p
  branch-heads/41
  branch-heads/41p
  branch-heads/42
  branch-heads/42p
  branch-heads/43
  branch-heads/44
  branch-heads/45
  branch-heads/46
  branch-heads/47
  branch-heads/48
  branch-heads/49
  branch-heads/50
  branch-heads/51
  branch-heads/52
  branch-heads/53
  branch-heads/54
  branch-heads/55
  branch-heads/56
  branch-heads/57
  branch-heads/58
  branch-heads/59
  branch-heads/60
  branch-heads/61
  branch-heads/62
  branch-heads/63
  branch-heads/64
  branch-heads/65
  branch-heads/66
  branch-heads/67
  branch-heads/68
  branch-heads/69
  branch-heads/70
  branch-heads/71
  branch-heads/72
  branch-heads/m73
  branch-heads/m74
  branch-heads/m75
  branch-heads/m76
  branch-heads/m77
  branch-heads/m78
  branch-heads/m79
  branch-heads/phoglund-test
  origin/HEAD -> origin/master
  origin/infra/config
  origin/lkgr
  origin/master
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git checkout -b m76 refs/remotes/branch-heads/m76
Switched to a new branch 'm76'
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch
* m76
  master
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git log
commit 9863f3d246e2da7a2e1f42bbc5757f6af5ec5682 (HEAD -> m76, branch-heads/m76)
Author: Qingsi Wang <qingsi@webrtc.org>
Date:   Mon Jul 15 13:11:46 2019 -0700

    Merge to M76: Use the dummy address 0.0.0.0:9 in the c= and the m= lines if the default connection address is a hostname candidate.
    
    Using a FQDN in the c= line has caused an inter-op issue with Firefox
    when hostname candidates are the only candidates gathered when forming
    the media sections. To address this issue, we use 0.0.0.0:9 when a
    hostname candidate would be used to populate the c= and the m= lines.
    
    The SDP grammar related to ICE candidates has been moved out of RFC8445,
    and is currently defined in draft-ietf-mmusic-ice-sip-sdp. A FQDN
    address must not be used in the connection address attribute per the
    latest draft, if the ICE agent generates local candidates. Also, the
    wildcard addresses  (0.0.0.0 or ::) with port 9 are given the exception
    as the connection address that will not result in an ICE mismatch. We
    thus adopt the aforementioned solution after combining these
    considerations.
    
    TBR=hta@webrtc.org
    
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ cd ..
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools	src
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ gclient sync -r 9863f3d246e2da7a2e1f42bbc5757f6af5ec5682 --force
using /var/folders/9r/mhg2f0g93csc7txyq__57lf80000gp/T/goma_suntongmian as tmpdir
INFO: creating cache dir (/var/folders/9r/mhg2f0g93csc7txyq__57lf80000gp/T/goma_suntongmian/goma_cache).
Syncing projects: 100% (38/38), done.                                           

________ running 'vpython src/build/landmines.py --landmine-scripts src/tools_webrtc/get_landmines.py --src-dir src' in '/Users/suntongmian/Documents/workplace/webrtc'
Clobbering due to:
--- old_landmines	Mon Oct 21 13:47:04 2019
+++ new_landmines	Mon Oct 21 15:30:40 2019
@@ -8 +7,0 @@
-Clobber to change neteq_rtpplay type to executable
Running hooks:  45% (10/22) mac_toolchain                 
________ running 'vpython src/build/mac_toolchain.py' in '/Users/suntongmian/Documents/workplace/webrtc'
Skipping Mac toolchain installation for mac
Running hooks:  54% (12/22) clang        
________ running 'vpython src/tools/clang/scripts/update.py' in '/Users/suntongmian/Documents/workplace/webrtc'
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-361212-67510fac-3.tgz .......... Done.
Running hooks: 100% (22/22)                     
________ running 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' in '/Users/suntongmian/Documents/workplace/webrtc'
/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/2d32cd78d75549a5d0795bb9fbe35a00663f949a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0395c5d0ac4a28beb557c1eaa703f47adf21fa35.nk.rx__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/07716dffe2905abde0ae7bec475106e476bc9b25...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_37b31cd784590ff7e0746051fbf28f10dbd2ea8b.nk.rx__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

/Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> Downloading src/resources/ConferenceMotion_1280_720_50.yuv...
5> Downloading src/resources/foreman_320x240.yuv...
1> Downloading src/resources/paris_qcif.yuv...
0> Downloading src/resources/foreman_cif.yuv...
6> Downloading src/resources/reference_less_video_test_file.y4m...
2> Downloading src/resources/foreman_cif_short.yuv...
4> Downloading src/resources/foreman_480x272.yuv...
3> Downloading src/resources/foreman_240x136.yuv...
8> Downloading src/resources/foreman_176x144.yuv...
7> Downloading src/resources/ref03.aecdump...
9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/60a92ea32e238bc2801ac2ca26827b8b10155978...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_920459e3ffabb5f50215fc0adf13efce50d67229.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/bb838d60f2a0454af4ca63735d573069858ec004...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0c27fa3755b299cb8fbe90e2d18481c0f77619bb.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

2> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/7398e204d06b34fcd09533523ec418af9b5caf80...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_1074777fc1c8e560f0e257210ddb0ffbcbdb4ebd.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/5a1620516daf59870158a66230d7bafd9fe9afa1...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_4b1ba77e6496b7cb2113d44f4296fe8d8b49cb31.e.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/117c0301ed19d83f0e112ea3e831dd389db68570...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_3f82caf3ac5fd9762cd23f1fba209cf2cf5e3231.6.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/4a38b5629845646844350a4257a60554888509b9...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_86538f712f65c51bb0ed35e7be3567e763371524.4.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

1> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/d19fb2879d091324c699987ab280da82af200933...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5e149c0ac6a7168a1c24a0375e67cafbf4bd4686.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/db8cc13114cfe550fefa264ea70427e1fa4f9bba...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_5164bfb83c4edeab462c23031dd784e447a0d888.f.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/04f9f47938efa99d0389672ff2d83c10f04a1752...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c041251a70267aaf706ed08700e4fe75e21fd3d4.cdump__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/65717a7be6dc7ce5d88afedc73e46838aa0a3abc...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_320a50cf6d6dcaca6ef494258859ebf77aaf6d9c.2.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> Downloading src/resources/verizon4g-uplink.rx...
9> Downloading src/resources/foreman_160x120.yuv...
2> Downloading src/resources/foremanColorEnhanced_cif_short.yuv...
1> Downloading src/resources/verizon4g-downlink.rx...
8> Downloading src/resources/reference_video_640x360_30fps.y4m...
6> Downloading src/resources/FourPeople_1280x720_30.yuv...
0> Downloading src/resources/deflicker_before_cif_short.yuv...
7> Downloading src/resources/audio_coding/speech_mono_32_48kHz.pcm...
4> Downloading src/resources/audio_coding/music_stereo_48kHz.pcm...
3> Downloading src/resources/audio_coding/speech_mono_16kHz.pcm...
9> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/315d8a7cc06fe15b68a6f2106d59d25b16270552...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_2754ccae3b287e688080bb499acf0cd8d6a14dc3.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

5> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/2d32cd78d75549a5d0795bb9fbe35a00663f949a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_0395c5d0ac4a28beb557c1eaa703f47adf21fa35.nk.rx__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

2> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/ce229fea854fbce532fe430b5b5a8c9b5db65d94...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_b3cfcb4514d1797cfd8139c25c59a8d6097af730.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

1> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/07716dffe2905abde0ae7bec475106e476bc9b25...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_37b31cd784590ff7e0746051fbf28f10dbd2ea8b.nk.rx__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/f9cabbf3a9c5562cd6cdfd19aae1cb5ef8a7ad7d...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_a07d5225a34109e94c19b6c1caac3bfbba6dbeac.s.y4m__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

3> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/89f191b706f8028e52ffd64525de1921eacd772a...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_666d5fd2f31afc106645c9bbffcde73cdd29e731.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

6> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/3baa38557757bb770f7cbeaa390e3a8a1e0c254c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/sliced_download_TRACKER_e27efab5db479a2a6f8aa969bd48f3b040ff430a.0.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

7> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/009a3ee778767c2402b1d2c920bc2449265f5a2c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_60e1e232faa80653ea952318299c7e7c057d2e2a.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

4> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/77b123a152911b538951cadbee45007f9d1a370c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_c88547f8ec6127e766f1e6c96e5d69b4a709b1d2.z.pcm__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

0> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/849f88896b1d00c2625c247e9e06a19d2ae0175c...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_74352293278f17333e6e3bf7fd9edcd9b6040a51.t.yuv__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

9> Downloading src/resources/audio_processing/output_data_float.pb...
5> Downloading src/resources/audio_processing/output_data_mac.pb...
2> Downloading src/resources/audio_processing/output_data_fixed.pb...
8> Downloading src/resources/audio_processing/test/py_quality_assessment/noise_tracks/city.wav...
8> /Users/suntongmian/Documents/workplace/webrtc/depot_tools/external_bin/gsutil/gsutil_4.28/gsutil/third_party/boto/boto/pyami/config.py:69: UserWarning: Unable to load AWS_CREDENTIAL_FILE ()
  warnings.warn('Unable to load AWS_CREDENTIAL_FILE (%s)' % full_path)
Copying gs://chromium-webrtc-resources/66b8430fe082093301c2307cd4482e80a0bd4fc5...
CommandException: Couldn't write tracker file (/Users/suntongmian/.gsutil/tracker-files/download_TRACKER_62af38a226f97ec371fda107f472ad8c60a23898.y.wav__JSON.etag): Permission denied. This can happen if gsutil is configured to save tracker files to an unwritable directory)

Downloading 272 files took 29.680667 second(s)
Error: Command 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' returned non-zero exit status 1 in /Users/suntongmian/Documents/workplace/webrtc
Hook 'download_from_google_storage --directory --recursive --num_threads=10 --no_auth --quiet --bucket chromium-webrtc-resources src/resources' took 33.28 secs
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$
```

> ### 后续

上面所述的步骤，针对正常的情形是没有任何问题的。为什么这么说？因为我在我的一台有大半年没有使用的 MacBook Pro 上操作源码更新时，想拉取 M76 分支，执行命令 **git branch -r** 只能看到 branch-heads/m75 为最新的分支，没有显示 branch-heads/m76， branch-heads/m77 ，branch-heads/m78，branch-heads/m79 分支。出现这样的情况，并不是本地源码没有同步到最新。参考文章 [Media/WebRTC/Updating Process](https://wiki.mozilla.org/Media/WebRTC/Updating_Process) 即可解决这个问题。

> #### 修改文件 .git/config

需要修改本地文件 /webrtc/src/.git/config，向该文件中添加：

```
fetch = +refs/branch-heads/*:refs/remotes/branch-heads/*
```

修改之后，该文件的内容为：

```
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
	ignorecase = true
	precomposeunicode = true
[remote "origin"]
	url = https://webrtc.googlesource.com/src.git
	fetch = +refs/heads/*:refs/remotes/origin/*
	fetch = +refs/branch-heads/*:refs/remotes/branch-heads/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
[diff]
	ignoreSubmodules = all
[branch "m76"]
	remote = origin
	merge = refs/branch-heads/m76
```

> #### 执行 git fetch

修改并保存 /webrtc/src/.git/config 后，在终端执行命令：

```
git fetch
```

> #### 执行 git branch -r

到这一步，执行命令：

```
git branch -r
```

此时，在终端上可以看到最新的所有分支信息了，就可以通过 **git checkout -b m76 refs/remotes/branch-heads/m76** 将 M76 分支 checkout 出来了。

> ### 参考文献

[1] [https://webrtc.org/native-code/development/](https://webrtc.org/native-code/development/)

[2] [Media/WebRTC/Updating Process](https://wiki.mozilla.org/Media/WebRTC/Updating_Process)
