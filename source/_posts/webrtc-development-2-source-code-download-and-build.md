---
title: WebRTC 开发（二）源码下载与编译
date: 2019-05-02 13:35:17
tags:
- WebRTC
- 音视频处理
---

在使用任何工具之前，我们都有必要对工具做大概地的了解，做到粗犷但不失偏颇，这对我们选用工具和切入点是很关键的。本节的标题虽然是 WebRTC 源码下载与编译，但在这之前，我们有必要大概地了解 WebRTC，比如开发机构、免费性、支持的平台、功能亮点。

WebRTC 是一个免费开源的跨平台项目，由 Google，Mozilla，Opera 等支持，支持 Chrome，Firefox，Opera 以及 Android 和 iOS 平台，能够给浏览器、手机应用和物联网设备提供了实时互动能力。

WebRTC 是一组协议和 API。WebRTC 的起源可追溯到 2011年，经过六年多的时间的发展，在 2017年底 WebRTC 1.0 标准正式出炉。通过 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 可以看到现在最新的 release 版本是 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ)。

2015年移动端直播的兴起，观众可以在手机端实时看主播的直播，但是观众与主播之间的沟通需要通过发弹幕来进行，这种交流的实时性较差，沟通不便利，观众参与感较差。2016年初移动端上出现了主播与观众之间可以通过实时视频聊天这种方式来沟通，即，视频连麦。那我们想实现这种视频连麦的功能该怎么做呢？

现在通过 WebRTC 以及其它一些音视频工具，我们就可以搭建一个视频聊天工具，做到视频连麦，也能做到类似于微信视频群聊。关于各种实现视频连麦的方式，这里就不细说了，放到后面的章节来解说。

了解到 WebRTC 是个什么东西后，通常人的心里就会产生一种跃跃欲试的冲动，想试试，那试试就试试呗。“磨刀不误砍柴工”这句话是有道理的，当我们没有经验和没有人传授经验的时候，那我们就要琢磨这句“磨刀不误砍柴工”了。我们要砍柴做饭，找到一把刀拿起就跑到树林里去砍柴，结果发现刀太钝，砍柴真费劲。这个时候，我们就意识到砍柴刀要用磨刀石磨一磨，磨锋利了，就能提升砍柴的效率。我举这个例子，就想说明两点：

<!-- more -->

第一，先尝试可以加深理解，获取自己的经验。

第二，通过获取的经验，重新调整，比如调整做事步骤，加深理论学习等。

WebRTC 支持 Windows, Mac OS X, Linux, Android 和 iOS 平台，这里以 iOS 平台为例来描述 WebRTC 的源码下载和编译过程。

> # 选择 Release 版本

## step 1

从 WebRTC 的 [Release Notes](https://webrtc.org/release-notes/) 的 release 版本中选择最新的版本，当前最新版为 [M74 Release Noted](https://groups.google.com/forum/#!msg/discuss-webrtc/cXEtXIIYrQs/R7y0yIK2AQAJ) 

```
WebRTC M74 Release Notes

WebRTC M74 branch (cut at r26981)

Summary

WebRTC M74, currently available in Chrome's beta channel and as native libraries for Android and iOS, contains feature additions like RID/MID based Simulcast, multiple bug fixes, enhancements and stability/performance improvements. As with previous releases, we encourage all developers to run versions of Chrome on the Canary, Dev, and Beta channels frequently and quickly report any issues found. Please take a look at this page, for some pointers on how to file a good bug report. The help we have received has been invaluable! 

The Chrome release schedule can be found here. Native libraries for Android and iOS are built on a weekly basis and are available on JCenter and CocoaPods; the Changelog is available here.
```

## step 2

进入分支 [WebRTC M74 branch](https://chromium.googlesource.com/external/webrtc/+log/branch-heads/m74) (cut at r26981)

```
chromium / external / webrtc / branch-heads/m74

741f9a0 Ignore duplicate sent packets in TransportFeedbackAdapter by Erik Språng · 2 weeks ago

e6d5f62 Merge to M74: Allow setting ALR values for screen content again by Erik Språng · 4 weeks ago

9c745ae Revert "Disable DTLS 1.0, TLS 1.0 and TLS 1.1 downgrade in WebRTC." by Benjamin Wright · 5 weeks ago

1c9bf93 Merge to M74: Fix bug in vp8 FrameDropThreshold by Erik Språng · 5 weeks ago

...

```

## step 3

选择第一条提交记录 [741f9a0 Ignore duplicate sent packets in TransportFeedbackAdapter by Erik Språng · 2 weeks ago] 进入详情页 [chromium / external / webrtc / 741f9a0679bc70682b056004f8421879352d1a8d](https://chromium.googlesource.com/external/webrtc/+/741f9a0679bc70682b056004f8421879352d1a8d)

```
chromium / external / webrtc / 741f9a0679bc70682b056004f8421879352d1a8d

commit	741f9a0679bc70682b056004f8421879352d1a8d	[log] [tgz]
author	Erik Språng <sprang@webrtc.org>	Thu Apr 18 12:28:02 2019
committer	Erik Språng <sprang@webrtc.org>	Fri Apr 19 17:51:34 2019
tree	36ee311fa41a5d60ab98d87273f210ac90ed3fdf
parent	e6d5f62d010d7f6284504af1c7898894851b238c [diff]

Ignore duplicate sent packets in TransportFeedbackAdapter

Bug: webrtc:10564, chromium:954139, webrtc:10509
Change-Id: I617b58ef8cf5858d7a81aaa39884c5cc1ac2af6e
Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133564
Commit-Queue: Erik Språng <sprang@webrtc.org>
Reviewed-by: Sebastian Jansson <srte@webrtc.org>
Cr-Original-Commit-Position: refs/heads/master@{#27689}(cherry picked from commit d50947ab516ec404b100752617fb828d05cf0e3d)
Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133579
Cr-Commit-Position: refs/branch-heads/m74@{#20}
Cr-Branched-From: be7af9399ceb88171bf60b50419ff2dec8184fb9-refs/heads/master@{#26981}

modules/congestion_controller/rtp/BUILD.gn[diff]
modules/congestion_controller/rtp/send_time_history.cc[diff]
modules/congestion_controller/rtp/send_time_history.h[diff]
modules/congestion_controller/rtp/transport_feedback_adapter.cc[diff]
modules/congestion_controller/rtp/transport_feedback_adapter.h[diff]
modules/congestion_controller/rtp/transport_feedback_adapter_unittest.cc[diff]
6 files changed

tree: 36ee311fa41a5d60ab98d87273f210ac90ed3fdf

...

```

获取到该分支的最新提交记录：**commit	741f9a0679bc70682b056004f8421879352d1a8d**。后面下载源码的时候要用到这个 commit 编号。

> # 安装 depot_tools 工具包

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
<!--STATUS OK--><html> <head><meta http-equiv=content-type content=text/html;charset=utf-8><meta http-equiv=X-UA-Compatible content=IE=Edge><meta content=always name=referrer><link rel=stylesheet type=text/css href=http://s1.bdstatic.com/r/www/cache/bdorz/baidu.min.css><title>百度一下，你就知道</title></head> <body link=#0000cc> <div id=wrapper> <div id=head> <div class=head_wrapper> <div class=s_form> <div class=s_form_wrapper> <div id=lg> <img hidefocus=true src=//www.baidu.com/img/bd_logo1.png width=270 height=129> </div> <form id=form name=f action=//www.baidu.com/s class=fm> <input type=hidden name=bdorz_come value=1> <input type=hidden name=ie value=utf-8> <input type=hidden name=f value=8> <input type=hidden name=rsv_bp value=1> <input type=hidden name=rsv_idx value=1> <input type=hidden name=tn value=baidu><span class="bg s_ipt_wr"><input id=kw name=wd class=s_ipt value maxlength=255 autocomplete=off autofocus></span><span class="bg s_btn_wr"><input type=submit id=su value=百度一下 class="bg s_btn"></span> </form> </div> </div> <div id=u1> <a href=http://news.baidu.com name=tj_trnews class=mnav>新闻</a> <a href=http://www.hao123.com name=tj_trhao123 class=mnav>hao123</a> <a href=http://map.baidu.com name=tj_trmap class=mnav>地图</a> <a href=http://v.baidu.com name=tj_trvideo class=mnav>视频</a> <a href=http://tieba.baidu.com name=tj_trtieba class=mnav>贴吧</a> <noscript> <a href=http://www.baidu.com/bdorz/login.gif?login&amp;tpl=mn&amp;u=http%3A%2F%2Fwww.baidu.com%2f%3fbdorz_come%3d1 name=tj_login class=lb>登录</a> </noscript> <script>document.write('<a href="http://www.baidu.com/bdorz/login.gif?login&tpl=mn&u='+ encodeURIComponent(window.location.href+ (window.location.search === "" ? "?" : "&")+ "bdorz_come=1")+ '" name="tj_login" class="lb">登录</a>');</script> <a href=//www.baidu.com/more/ name=tj_briicon class=bri style="display: block;">更多产品</a> </div> </div> </div> <div id=ftCon> <div id=ftConw> <p id=lh> <a href=http://home.baidu.com>关于百度</a> <a href=http://ir.baidu.com>About Baidu</a> </p> <p id=cp>&copy;2017&nbsp;Baidu&nbsp;<a href=http://www.baidu.com/duty/>使用百度前必读</a>&nbsp; <a href=http://jianyi.baidu.com/ class=cp-feedback>意见反馈</a>&nbsp;京ICP证030173号&nbsp; <img src=//www.baidu.com/img/gs.gif> </p> </div> </div> </div> </body> </html>
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
<!doctype html><html itemscope="" itemtype="http://schema.org/WebPage" lang="en"><head><meta content="Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for." name="description"><meta content="noodp" name="robots"><meta content="text/html; charset=UTF-8" http-equiv="Content-Type"><meta content="/logos/doodles/2019/us-teacher-appreciation-week-2019-begins-4994791740801024-l.png" itemprop="image"><meta content="Happy US Teacher Appreciation Week 2019!" property="twitter:title"><meta content="Happy US Teacher Appreciation Week 2019! #GoogleDoodle" property="twitter:description"><meta content="Happy US Teacher Appreciation Week 2019! #GoogleDoodle" property="og:description"><meta content="summary_large_image" property="twitter:card"><meta content="@GoogleDoodles" property="twitter:site"><meta content="https://www.google.com/logos/doodles/2019/us-teacher-appreciation-week-2019-begins-4994791740801024-2x.jpg" property="twitter:image"><meta content="https://www.google.com/logos/doodles/2019/us-teacher-appreciation-week-2019-begins-4994791740801024-2x.jpg" property="og:image"><meta content="782" property="og:image:width"><meta content="400" property="og:image:height"><title>Google</title><script nonce="1cF5wiybAk0ZW7RYxuJPNw==">(function(){window.google={kEI:'NETQXJuTBIqw0wLW9pvwDA',kEXPI:'0,1353747,57,1958,2422,697,528,591,139,224,756,819,1258,1893,57,528,144,206,441,226,138,17,482,2332972,322,329193,1294,12383,4855,32691,15248,867,12163,6381,854,2481,2,2,6801,364,3319,1263,4242,224,2209,269,4203,904,575,835,284,2,578,728,2432,58,2,1,3,1297,4323,3700,1267,774,2248,1409,3337,1146,5,2,2,1745,218,2595,3601,669,1050,1808,1397,81,7,1,2,488,620,29,1395,978,2632,5299,1288,2,622,3385,796,1221,37,622,298,753,120,1217,1364,1611,2736,1558,1503,2,631,2562,2,4,2,461,209,46,1764,1979,403,510,125,1594,1013,12,620,2228,655,19,91,228,1593,389,866,326,197,777,1,2,151,215,1017,300,608,97,756,98,392,29,400,992,1107,10,168,9,84,24,187,831,235,78,365,367,450,174,563,167,237,48,553,11,14,10,573,1089,856,37,5,394,141,5,371,10,25,177,130,193,5,55,1110,87,67,89,385,155,144,324,165,28,532,277,93,86,84,103,24,160,68,39,18,21,18,326,276,1226,84,143,291,39,11,59,15,10,112,226,415,183,23,713,213,152,123,105,433,526,1,3,7,7,1,2,185,565,394,11,4,236,97,23,490,646,639,57,45,55,23,22,293,370,327,39,19,163,359,35,82,62,6,452,886,74,337,5937571,2920,5997516,40,2799864,4,1572,549,333,444,1,2,80,1,900,583,1,312,1,8,1,2,2132,1,1,1,1,1,414,1,748,141,59,726,3,7,563,1,1907,6,3,11,84,4,8,8,2,4,4,22,22305075',authuser:0,kscs:'c9c918f0_NETQXJuTBIqw0wLW9pvwDA',kGL:'US'};google.sn='webhp';google.kHL='en';})();(function(){google.lc=[];google.li=0;google.getEI=function(a){for(var b;a&&(!a.getAttribute||!(b=a.getAttribute("eid")));)a=a.parentNode;return b||google.kEI};google.getLEI=function(a){for(var b=null;a&&(!a.getAttribute||!(b=a.getAttribute("leid")));)a=a.parentNode;return b};google.https=function(){return"https:"==window.location.protocol};google.ml=function(){return null};google.time=function(){return(new Date).getTime()};google.log=function(a,b,e,c,g){if(a=google.logUrl(a,b,e,c,g)){b=new Image;var d=google.lc,f=google.li;d[f]=b;b.onerror=b.onload=b.onabort=function(){delete d[f]};google.vel&&google.vel.lu&&google.vel.lu(a);b.src=a;google.li=f+1}};google.logUrl=function(a,b,e,c,g){var d="",f=google.ls||"";e||-1!=b.search("&ei=")||(d="&ei="+google.getEI(c),-1==b.search("&lei=")&&(c=google.getLEI(c))&&(d+="&lei="+c));c="";!e&&google.cshid&&-1==b.search("&cshid=")&&"slh"!=a&&(c="&cshid="+google.cshid);a=e||"/"+(g||"gen_204")+"?atyp=i&ct="+a+"&cad="+b+d+f+"&zx="+google.time()+c;/^http:/i.test(a)&&google.https()&&(google.ml(Error("a"),!1,{src:a,glmm:1}),a="");return a};}).call(this);(function(){google.y={};google.x=function(a,b){if(a)var c=a.id;else{do c=Math.random();while(google.y[c])}google.y[c]=[a,b];return!1};google.lm=[];google.plm=function(a){google.lm.push.apply(google.lm,a)};google.lq=[];google.load=function(a,b,c){google.lq.push([[a],b,c])};google.loadAll=function(a,b){google.lq.push([a,b])};}).call(this);google.f={};var a=window.location,b=a.href.indexOf("#");if(0<=b){var c=a.href.substring(b+1);/(^|&)q=/.test(c)&&-1==c.indexOf("#")&&a.replace("/search?"+c.replace(/(^|&)fp=[^&]*/g,"")+"&cad=h")};</script><style>#gbar,#guser{font-size:13px;padding-top:1px !important;}#gbar{height:22px}#guser{padding-bottom:7px !important;text-align:right}.gbh,.gbd{border-top:1px solid #c9d7f1;font-size:1px}.gbh{height:0;position:absolute;top:24px;width:100%}@media all{.gb1{height:22px;margin-right:.5em;vertical-align:top}#gbar{float:left}}a.gb1,a.gb4{text-decoration:underline !important}a.gb1,a.gb4{color:#00c !important}.gbi .gb4{color:#dd8e27 !important}.gbf .gb4{color:#900 !important}
</style><style>body,td,a,p,.h{font-family:arial,sans-serif}body{margin:0;overflow-y:scroll}#gog{padding:3px 8px 0}td{line-height:.8em}.gac_m td{line-height:17px}form{margin-bottom:20px}.h{color:#36c}.q{color:#00c}.ts td{padding:0}.ts{border-collapse:collapse}em{font-weight:bold;font-style:normal}.lst{height:25px;width:496px}.gsfi,.lst{font:18px arial,sans-serif}.gsfs{font:17px arial,sans-serif}.ds{display:inline-box;display:inline-block;margin:3px 0 4px;margin-left:4px}input{font-family:inherit}a.gb1,a.gb2,a.gb3,a.gb4{color:#11c !important}body{background:#fff;color:black}a{color:#11c;text-decoration:none}a:hover,a:active{text-decoration:underline}.fl a{color:#36c}a:visited{color:#551a8b}a.gb1,a.gb4{text-decoration:underline}a.gb3:hover{text-decoration:none}#ghead a.gb2:hover{color:#fff !important}.sblc{padding-top:5px}.sblc a{display:block;margin:2px 0;margin-left:13px;font-size:11px}.lsbb{background:#eee;border:solid 1px;border-color:#ccc #999 #999 #ccc;height:30px}.lsbb{display:block}.ftl,#fll a{display:inline-block;margin:0 12px}.lsb{background:url(/images/nav_logo229.png) 0 -261px repeat-x;border:none;color:#000;cursor:pointer;height:30px;margin:0;outline:0;font:15px arial,sans-serif;vertical-align:top}.lsb:active{background:#ccc}.lst:focus{outline:none}</style><script nonce="1cF5wiybAk0ZW7RYxuJPNw=="></script></head><body bgcolor="#fff"><script nonce="1cF5wiybAk0ZW7RYxuJPNw==">(function(){var src='/images/nav_logo229.png';var iesg=false;document.body.onload = function(){window.n && window.n();if (document.images){new Image().src=src;}
if (!iesg){document.f&&document.f.q.focus();document.gbqf&&document.gbqf.q.focus();}
}
})();</script><div id="mngb"> <div id=gbar><nobr><b class=gb1>Search</b> <a class=gb1 href="http://www.google.com/imghp?hl=en&tab=wi">Images</a> <a class=gb1 href="http://maps.google.com/maps?hl=en&tab=wl">Maps</a> <a class=gb1 href="https://play.google.com/?hl=en&tab=w8">Play</a> <a class=gb1 href="http://www.youtube.com/?gl=US&tab=w1">YouTube</a> <a class=gb1 href="http://news.google.com/nwshp?hl=en&tab=wn">News</a> <a class=gb1 href="https://mail.google.com/mail/?tab=wm">Gmail</a> <a class=gb1 href="https://drive.google.com/?tab=wo">Drive</a> <a class=gb1 style="text-decoration:none" href="https://www.google.com/intl/en/about/products?tab=wh"><u>More</u> &raquo;</a></nobr></div><div id=guser width=100%><nobr><span id=gbn class=gbi></span><span id=gbf class=gbf></span><span id=gbe></span><a href="http://www.google.com/history/optout?hl=en" class=gb4>Web History</a> | <a  href="/preferences?hl=en" class=gb4>Settings</a> | <a target=_top id=gb_70 href="https://accounts.google.com/ServiceLogin?hl=en&passive=true&continue=http://www.google.com/" class=gb4>Sign in</a></nobr></div><div class=gbh style=left:0></div><div class=gbh style=right:0></div> </div><center><br clear="all" id="lgpd"><div id="lga"><a href="/search?ie=UTF-8&amp;q=teacher+appreciation+week&amp;oi=ddle&amp;ct=120236436&amp;hl=en&amp;kgmid=/m/0_m0g58&amp;sa=X&amp;ved=0ahUKEwib_c2ljofiAhUK2FQKHVb7Bs4QPQgD"><img alt="Happy US Teacher Appreciation Week 2019!" border="0" height="220" src="/logos/doodles/2019/us-teacher-appreciation-week-2019-begins-4994791740801024-l.png" title="Happy US Teacher Appreciation Week 2019!" width="430" id="hplogo" onload="window.lol&&lol()"><br></a><br></div><form action="/search" name="f"><table cellpadding="0" cellspacing="0"><tr valign="top"><td width="25%">&nbsp;</td><td align="center" nowrap=""><input name="ie" value="ISO-8859-1" type="hidden"><input value="en" name="hl" type="hidden"><input name="source" type="hidden" value="hp"><input name="biw" type="hidden"><input name="bih" type="hidden"><div class="ds" style="height:32px;margin:4px 0"><input style="color:#000;margin:0;padding:5px 8px 0 6px;vertical-align:top" autocomplete="off" class="lst" value="" title="Google Search" maxlength="2048" name="q" size="57"></div><br style="line-height:0"><span class="ds"><span class="lsbb"><input class="lsb" value="Google Search" name="btnG" type="submit"></span></span><span class="ds"><span class="lsbb"><input class="lsb" value="I'm Feeling Lucky" name="btnI" onclick="if(this.form.q.value)this.checked=1; else top.location='/doodles/'" type="submit"></span></span></td><td class="fl sblc" align="left" nowrap="" width="25%"><a href="/advanced_search?hl=en&amp;authuser=0">Advanced search</a><a href="/language_tools?hl=en&amp;authuser=0">Language tools</a></td></tr></table><input id="gbv" name="gbv" type="hidden" value="1"><script nonce="1cF5wiybAk0ZW7RYxuJPNw==">(function(){var a,b="1";if(document&&document.getElementById)if("undefined"!=typeof XMLHttpRequest)b="2";else if("undefined"!=typeof ActiveXObject){var c,d,e=["MSXML2.XMLHTTP.6.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP","Microsoft.XMLHTTP"];for(c=0;d=e[c++];)try{new ActiveXObject(d),b="2"}catch(h){}}a=b;if("2"==a&&-1==location.search.indexOf("&gbv=2")){var f=google.gbvu,g=document.getElementById("gbv");g&&(g.value=a);f&&window.setTimeout(function(){location.href=f},0)};}).call(this);</script></form><div id="gac_scont"></div><div style="font-size:83%;min-height:3.5em"><br><div id="prm"><style>.szppmdbYutt__middle-slot-promo{font-size:small;margin-bottom:32px}.szppmdbYutt__middle-slot-promo a.ZIeIlb{display:inline-block;text-decoration:none}.szppmdbYutt__middle-slot-promo img{border:none;margin-right:5px;vertical-align:middle}</style><div class="szppmdbYutt__middle-slot-promo" data-ved="0ahUKEwib_c2ljofiAhUK2FQKHVb7Bs4QnIcBCAQ"><a class="NKcBbd" href="https://www.google.com/url?q=https://www.blog.google/outreach-initiatives/education/teacher-appreciation-week-2019/%3Futm_source%3Dgoogle%26utm_medium%3Dhpp%26utm_campaign%3Dtaw_2019&amp;source=hpp&amp;id=19012032&amp;ct=3&amp;usg=AFQjCNEqnJb2uHoMjg2Wud6MtvKcn2ILpg&amp;sa=X&amp;ved=0ahUKEwib_c2ljofiAhUK2FQKHVb7Bs4Q8IcBCAU" rel="nofollow">We&#8217;re supporting teachers inspiring the next generation</a></div></div></div><span id="footer"><div style="font-size:10pt"><div style="margin:19px auto;text-align:center" id="fll"><a href="/intl/en/ads/">Advertising?Programs</a><a href="/services/">Business Solutions</a><a href="/intl/en/about.html">About Google</a></div></div><p style="color:#767676;font-size:8pt">&copy; 2019 - <a href="/intl/en/policies/privacy/">Privacy</a> - <a href="/intl/en/policies/terms/">Terms</a></p></span></center><script nonce="1cF5wiybAk0ZW7RYxuJPNw==">(function(){window.google.cdo={height:0,width:0};(function(){var a=window.innerWidth,b=window.innerHeight;if(!a||!b){var c=window.document,d="CSS1Compat"==c.compatMode?c.documentElement:c.body;a=d.clientWidth;b=d.clientHeight}a&&b&&(a!=google.cdo.width||b!=google.cdo.height)&&google.log("","","/client_204?&atyp=i&biw="+a+"&bih="+b+"&ei="+google.kEI);}).call(this);})();(function(){var u='/xjs/_/js/k\x3dxjs.hp.en_US.Yv_bmieVcKQ.O/m\x3dsb_he,d/am\x3dwKAW/rt\x3dj/d\x3d1/rs\x3dACT90oG3DzwVTl5n4Q_0THsxrUHGQsAO3g';setTimeout(function(){var a=document.createElement("script");a.src=u;google.timers&&google.timers.load&&google.tick&&google.tick("load","xjsls");document.body.appendChild(a)},0);})();(function(){window.google.xjsu='/xjs/_/js/k\x3dxjs.hp.en_US.Yv_bmieVcKQ.O/m\x3dsb_he,d/am\x3dwKAW/rt\x3dj/d\x3d1/rs\x3dACT90oG3DzwVTl5n4Q_0THsxrUHGQsAO3g';})();function _DumpException(e){throw e;}
function _F_installCss(c){}
(function(){google.spjs=false;})();google.sm=1;(function(){var pmc='{\x22Qnk92g\x22:{},\x22RWGcrA\x22:{},\x22U5B21g\x22:{},\x22YFCs/g\x22:{},\x22ZI/YVQ\x22:{},\x22d\x22:{},\x22sb_he\x22:{\x22agen\x22:true,\x22cgen\x22:true,\x22client\x22:\x22heirloom-hp\x22,\x22dh\x22:true,\x22dhqt\x22:true,\x22ds\x22:\x22\x22,\x22ffql\x22:\x22en\x22,\x22fl\x22:true,\x22host\x22:\x22google.com\x22,\x22isbh\x22:28,\x22jsonp\x22:true,\x22msgs\x22:{\x22cibl\x22:\x22Clear Search\x22,\x22dym\x22:\x22Did you mean:\x22,\x22lcky\x22:\x22I\\u0026#39;m Feeling Lucky\x22,\x22lml\x22:\x22Learn more\x22,\x22oskt\x22:\x22Input tools\x22,\x22psrc\x22:\x22This search was removed from your \\u003Ca href\x3d\\\x22/history\\\x22\\u003EWeb History\\u003C/a\\u003E\x22,\x22psrl\x22:\x22Remove\x22,\x22sbit\x22:\x22Search by image\x22,\x22srch\x22:\x22Google Search\x22},\x22ovr\x22:{},\x22pq\x22:\x22\x22,\x22refpd\x22:true,\x22rfs\x22:[],\x22sbpl\x22:24,\x22sbpr\x22:24,\x22scd\x22:10,\x22sce\x22:5,\x22stok\x22:\x22s4ND7ehgr2lcHpcv5T93UySs4ho\x22,\x22uhde\x22:false}}';google.pmc=JSON.parse(pmc);})();</script>        </body></html>suntongmiandeMacBook-Pro:webrtc suntongmian$ 
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

在终端执行如下命令

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

> # 下载 WebRTC 源码

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
Receiving objects:  62% (198983/320504), 99.53 MiB | 1.15 MiB/s   
[0:01:20] Still working on:
[0:01:20]   src
Receiving objects:  64% (205195/320504), 112.59 MiB | 1.25 MiB/s     
[0:01:30] Still working on:
[0:01:30]   src
Receiving objects:  64% (206287/320504), 127.59 MiB | 1.64 MiB/s   
[0:01:40] Still working on:
[0:01:40]   src
Receiving objects:  66% (211727/320504), 138.71 MiB | 1.17 MiB/s     
[0:01:50] Still working on:
[0:01:50]   src
Receiving objects:  66% (212334/320504), 144.40 MiB | 573.00 KiB/s   
[0:02:00] Still working on:
[0:02:00]   src
Receiving objects:  67% (214856/320504), 151.96 MiB | 815.00 KiB/s   
[0:02:10] Still working on:
[0:02:10]   src
Receiving objects:  69% (221994/320504), 163.95 MiB | 1.41 MiB/s   
[0:02:20] Still working on:
[0:02:20]   src
Receiving objects:  71% (230570/320504), 174.51 MiB | 997.00 KiB/s    
[0:02:30] Still working on:
[0:02:30]   src
Receiving objects:  80% (256404/320504), 184.07 MiB | 1.43 MiB/s     
[0:02:40] Still working on:
[0:02:40]   src
Receiving objects:  86% (276405/320504), 197.69 MiB | 1.40 MiB/s   
[0:02:50] Still working on:
[0:02:50]   src
Receiving objects:  95% (304479/320504), 210.75 MiB | 1.38 MiB/s   
[0:03:00] Still working on:
[0:03:00]   src
Receiving objects:  98% (315231/320504), 224.59 MiB | 1.18 MiB/s   
[0:03:10] Still working on:
[0:03:10]   src
Receiving objects:  98% (315246/320504), 234.05 MiB | 929.00 KiB/s   
[0:03:20] Still working on:
[0:03:20]   src
Receiving objects:  99% (320126/320504), 244.74 MiB | 1.02 MiB/s     
[0:03:30] Still working on:
[0:03:30]   src
remote: Total 320504 (delta 243613), reused 320495 (delta 243613)        
Receiving objects: 100% (320504/320504), 253.18 MiB | 1.20 MiB/s, done.
Resolving deltas:  75% (184825/243613)   
[0:03:40] Still working on:
[0:03:40]   src
Resolving deltas: 100% (243613/243613), done.

[0:03:50] Still working on:
[0:03:50]   src
Syncing projects:   0% ( 0/ 2) 
[0:03:59] Still working on:
[0:03:59]   src
Syncing projects:  15% ( 6/38) src/buildtools/third_party/libunwind/trunk
[0:05:50] Still working on:
[0:05:50]   src/base
[0:05:50]   src/build
[0:05:50]   src/ios
[0:05:50]   src/testing
[0:05:50]   src/third_party
[0:05:50]   src/tools
[0:05:50]   src/buildtools/third_party/libc++/trunk

[0:05:52] Still working on:
[0:05:52]   src/base
[0:05:52]   src/build
[0:05:52]   src/ios
[0:05:52]   src/testing
[0:05:52]   src/third_party
[0:05:52]   src/tools
[0:05:52]   src/buildtools/third_party/libc++/trunk
Syncing projects:  18% ( 7/38) src/buildtools/third_party/libc++/trunk   
[0:06:52] Still working on:
[0:06:52]   src/base
[0:06:52]   src/build
[0:06:52]   src/ios
[0:06:52]   src/testing
[0:06:52]   src/third_party
[0:06:52]   src/tools

[0:07:02] Still working on:
[0:07:02]   src/base
[0:07:02]   src/build
[0:07:02]   src/ios
[0:07:02]   src/testing
[0:07:02]   src/third_party
[0:07:02]   src/tools

[0:07:12] Still working on:
[0:07:12]   src/base
[0:07:12]   src/build
[0:07:12]   src/ios
[0:07:12]   src/testing
[0:07:12]   src/third_party
[0:07:12]   src/tools

...

[2:03:16] Still working on:
[2:03:16]   src/third_party/icu

[2:03:26] Still working on:
[2:03:26]   src/third_party/icu

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
suntongmiandeMacBook-Pro:webrtc suntongmian$ gclient sync
Syncing projects: 100% (38/38), done.                                                     

________ running '/usr/bin/python src/build/mac_toolchain.py' in '/Users/suntongmian/Documents/develop/webrtc'
Skipping Mac toolchain installation for mac

________ running '/usr/bin/python src/tools/clang/scripts/update.py' in '/Users/suntongmian/Documents/develop/webrtc'
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-357692-1.tgz 
<urlopen error [Errno 54] Connection reset by peer>
Retrying in 5 s ...
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-357692-1.tgz 
<urlopen error [Errno 54] Connection reset by peer>
Retrying in 10 s ...
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-357692-1.tgz 
<urlopen error [Errno 54] Connection reset by peer>
Retrying in 20 s ...
Downloading https://commondatastorage.googleapis.com/chromium-browser-clang/Mac/clang-357692-1.tgz Traceback (most recent call last):
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
Hook '/usr/bin/python src/tools/clang/scripts/update.py' took 35.18 secs
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
```

## step 3

进入 src 目录，依据 741f9a0679bc70682b056004f8421879352d1a8d 检出一个新分支。741f9a0679bc70682b056004f8421879352d1a8d 是 “选择 Release 版本” 步骤中获取的 M74 Release 版本的 commit 编号信息。在终端执行命令

```
cd src
git branch M74-Release 741f9a0679bc70682b056004f8421879352d1a8d
git checkout M74-Release
git log
```

```
suntongmiandeMacBook-Pro:webrtc suntongmian$ ls
depot_tools	src
suntongmiandeMacBook-Pro:webrtc suntongmian$ 
suntongmiandeMacBook-Pro:webrtc suntongmian$ cd src
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ ls
AUTHORS			call			pylintrc
BUILD.gn		codereview.settings	resources
CODE_OF_CONDUCT.md	common_audio		rtc_base
DEPS			common_types.h		rtc_tools
ENG_REVIEW_OWNERS	common_video		sdk
LICENSE			crypto			stats
OWNERS			data			style-guide
PATENTS			examples		style-guide.md
PRESUBMIT.py		ios			system_wrappers
README.chromium		license_template.txt	test
README.md		logging			testing
WATCHLISTS		media			third_party
abseil-in-webrtc.md	modules			tools
api			native-api.md		tools_webrtc
audio			out			video
base			p2p			webrtc.gni
build			pc			whitespace.txt
build_overrides		presubmit_test.py
buildtools		presubmit_test_mocks.py
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch M74-Release 741f9a0679bc70682b056004f8421879352d1a8d
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git status
位于分支 master
您的分支与上游分支 'origin/master' 一致。

无文件要提交，干净的工作区
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch
  M74-Release
* master
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git checkout M74-Release
切换到分支 'M74-Release'
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git status
位于分支 M74-Release
无文件要提交，干净的工作区
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git branch
* M74-Release
  master
suntongmiandeMacBook-Pro:src suntongmian$ 
suntongmiandeMacBook-Pro:src suntongmian$ git log
commit 741f9a0679bc70682b056004f8421879352d1a8d (HEAD -> M74-Release, branch-heads/m74)
Author: Erik Språng <sprang@webrtc.org>
Date:   Thu Apr 18 14:28:02 2019 +0200

    Ignore duplicate sent packets in TransportFeedbackAdapter
    
    Bug: webrtc:10564, chromium:954139, webrtc:10509
    Change-Id: I617b58ef8cf5858d7a81aaa39884c5cc1ac2af6e
    Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133564
    Commit-Queue: Erik Språng <sprang@webrtc.org>
    Reviewed-by: Sebastian Jansson <srte@webrtc.org>
    Cr-Original-Commit-Position: refs/heads/master@{#27689}(cherry picked from commit d50947ab516ec404b100752617fb828d05cf0e3d)
    Reviewed-on: https://webrtc-review.googlesource.com/c/src/+/133579
    Cr-Commit-Position: refs/branch-heads/m74@{#20}
    Cr-Branched-From: be7af9399ceb88171bf60b50419ff2dec8184fb9-refs/heads/master@{#26981}

commit e6d5f62d010d7f6284504af1c7898894851b238c
Author: Erik Språng <sprang@webrtc.org>
Date:   Wed Apr 3 20:20:42 2019 +0200

    Merge to M74: Allow setting ALR values for screen content again
    
suntongmiandeMacBook-Pro:src suntongmian$ 
```

> # 执行编译

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
../../third_party/llvm-build/Release+Asserts/bin/clang++ -MMD -MF obj/api/audio_codecs/audio_codecs_api/audio_codec_pair_id.o.d -DNO_TCMALLOC -DCHROMIUM_BUILD -DCR_XCODE_VERSION=1020 -DCR_CLANG_REVISION=\"357692-1\" -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D_LIBCPP_ABI_UNSTABLE -D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCPP_ENABLE_NODISCARD -DCR_LIBCXX_REVISION=358423 -D_DEBUG -DDYNAMIC_ANNOTATIONS_ENABLED=1 -DWTF_USE_DYNAMIC_ANNOTATIONS=1 -DWEBRTC_ENABLE_PROTOBUF=1 -DWEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE -DRTC_ENABLE_VP9 -DHAVE_SCTP -DWEBRTC_ARCH_ARM64 -DWEBRTC_HAS_NEON -DWEBRTC_LIBRARY_IMPL -DWEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 -DWEBRTC_POSIX -DWEBRTC_MAC -DWEBRTC_IOS -DABSL_ALLOCATOR_NOTHROW=1 -I../.. -Igen -I../../third_party/abseil-cpp -fno-strict-aliasing --param=ssp-buffer-size=4 -fstack-protector -fcolor-diagnostics -fmerge-all-constants -fcrash-diagnostics-dir=../../tools/clang/crashreports -Xclang -mllvm -Xclang -instcombine-lower-dbg-declare=0 -fcomplete-member-pointers -arch arm64 -fno-experimental-isel -Wno-builtin-macro-redefined -D__DATE__= -D__TIME__= -D__TIMESTAMP__= -no-canonical-prefixes -Wall -Werror -Wextra -Wimplicit-fallthrough -Wthread-safety -Wextra-semi -Wunguarded-availability -Wundeclared-selector -Wno-missing-field-initializers -Wno-unused-parameter -Wno-c++11-narrowing -Wno-unneeded-internal-declaration -Wno-undefined-var-template -Wno-ignored-pragma-optimize -O0 -fno-omit-frame-pointer -g2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.2.sdk -stdlib=libc++ -miphoneos-version-min=10.0 -fvisibility=hidden -Wheader-hygiene -Wstring-conversion -Wtautological-overlap-compare -Wexit-time-destructors -Wglobal-constructors -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wc++11-narrowing -Wimplicit-fallthrough -Wthread-safety -Winconsistent-missing-override -Wundef -Wunused-lambda-capture -Wno-shorten-64-to-32 -Wno-undefined-bool-conversion -Wno-tautological-undefined-compare -std=c++11 -fno-exceptions -fno-rtti -nostdinc++ -isystem../../buildtools/third_party/libc++/trunk/include -isystem../../buildtools/third_party/libc++abi/trunk/include -fvisibility-inlines-hidden -Wnon-virtual-dtor -Woverloaded-virtual -c ../../api/audio_codecs/audio_codec_pair_id.cc -o obj/api/audio_codecs/audio_codecs_api/audio_codec_pair_id.o
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory
[2/2732] CXX obj/api/audio_codecs/audio_codecs_api/audio_decoder.o
FAILED: obj/api/audio_codecs/audio_codecs_api/audio_decoder.o 
../../third_party/llvm-build/Release+Asserts/bin/clang++ -MMD -MF obj/api/audio_codecs/audio_codecs_api/audio_decoder.o.d -DNO_TCMALLOC -DCHROMIUM_BUILD -DCR_XCODE_VERSION=1020 -DCR_CLANG_REVISION=\"357692-1\" -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D_LIBCPP_ABI_UNSTABLE -D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCPP_ENABLE_NODISCARD -DCR_LIBCXX_REVISION=358423 -D_DEBUG -DDYNAMIC_ANNOTATIONS_ENABLED=1 -DWTF_USE_DYNAMIC_ANNOTATIONS=1 -DWEBRTC_ENABLE_PROTOBUF=1 -DWEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE -DRTC_ENABLE_VP9 -DHAVE_SCTP -DWEBRTC_ARCH_ARM64 -DWEBRTC_HAS_NEON -DWEBRTC_LIBRARY_IMPL -DWEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 -DWEBRTC_POSIX -DWEBRTC_MAC -DWEBRTC_IOS -DABSL_ALLOCATOR_NOTHROW=1 -I../.. -Igen -I../../third_party/abseil-cpp -fno-strict-aliasing --param=ssp-buffer-size=4 -fstack-protector -fcolor-diagnostics -fmerge-all-constants -fcrash-diagnostics-dir=../../tools/clang/crashreports -Xclang -mllvm -Xclang -instcombine-lower-dbg-declare=0 -fcomplete-member-pointers -arch arm64 -fno-experimental-isel -Wno-builtin-macro-redefined -D__DATE__= -D__TIME__= -D__TIMESTAMP__= -no-canonical-prefixes -Wall -Werror -Wextra -Wimplicit-fallthrough -Wthread-safety -Wextra-semi -Wunguarded-availability -Wundeclared-selector -Wno-missing-field-initializers -Wno-unused-parameter -Wno-c++11-narrowing -Wno-unneeded-internal-declaration -Wno-undefined-var-template -Wno-ignored-pragma-optimize -O0 -fno-omit-frame-pointer -g2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.2.sdk -stdlib=libc++ -miphoneos-version-min=10.0 -fvisibility=hidden -Wheader-hygiene -Wstring-conversion -Wtautological-overlap-compare -Wexit-time-destructors -Wglobal-constructors -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wc++11-narrowing -Wimplicit-fallthrough -Wthread-safety -Winconsistent-missing-override -Wundef -Wunused-lambda-capture -Wno-shorten-64-to-32 -Wno-undefined-bool-conversion -Wno-tautological-undefined-compare -std=c++11 -fno-exceptions -fno-rtti -nostdinc++ -isystem../../buildtools/third_party/libc++/trunk/include -isystem../../buildtools/third_party/libc++abi/trunk/include -fvisibility-inlines-hidden -Wnon-virtual-dtor -Woverloaded-virtual -c ../../api/audio_codecs/audio_decoder.cc -o obj/api/audio_codecs/audio_codecs_api/audio_decoder.o
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory
[3/2732] CXX obj/api/audio_codecs/audio_codecs_api/audio_encoder.o
FAILED: obj/api/audio_codecs/audio_codecs_api/audio_encoder.o 
../../third_party/llvm-build/Release+Asserts/bin/clang++ -MMD -MF obj/api/audio_codecs/audio_codecs_api/audio_encoder.o.d -DNO_TCMALLOC -DCHROMIUM_BUILD -DCR_XCODE_VERSION=1020 -DCR_CLANG_REVISION=\"357692-1\" -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D_LIBCPP_ABI_UNSTABLE -D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCPP_ENABLE_NODISCARD -DCR_LIBCXX_REVISION=358423 -D_DEBUG -DDYNAMIC_ANNOTATIONS_ENABLED=1 -DWTF_USE_DYNAMIC_ANNOTATIONS=1 -DWEBRTC_ENABLE_PROTOBUF=1 -DWEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE -DRTC_ENABLE_VP9 -DHAVE_SCTP -DWEBRTC_ARCH_ARM64 -DWEBRTC_HAS_NEON -DWEBRTC_LIBRARY_IMPL -DWEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 -DWEBRTC_POSIX -DWEBRTC_MAC -DWEBRTC_IOS -DABSL_ALLOCATOR_NOTHROW=1 -I../.. -Igen -I../../third_party/abseil-cpp -fno-strict-aliasing --param=ssp-buffer-size=4 -fstack-protector -fcolor-diagnostics -fmerge-all-constants -fcrash-diagnostics-dir=../../tools/clang/crashreports -Xclang -mllvm -Xclang -instcombine-lower-dbg-declare=0 -fcomplete-member-pointers -arch arm64 -fno-experimental-isel -Wno-builtin-macro-redefined -D__DATE__= -D__TIME__= -D__TIMESTAMP__= -no-canonical-prefixes -Wall -Werror -Wextra -Wimplicit-fallthrough -Wthread-safety -Wextra-semi -Wunguarded-availability -Wundeclared-selector -Wno-missing-field-initializers -Wno-unused-parameter -Wno-c++11-narrowing -Wno-unneeded-internal-declaration -Wno-undefined-var-template -Wno-ignored-pragma-optimize -O0 -fno-omit-frame-pointer -g2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.2.sdk -stdlib=libc++ -miphoneos-version-min=10.0 -fvisibility=hidden -Wheader-hygiene -Wstring-conversion -Wtautological-overlap-compare -Wexit-time-destructors -Wglobal-constructors -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wc++11-narrowing -Wimplicit-fallthrough -Wthread-safety -Winconsistent-missing-override -Wundef -Wunused-lambda-capture -Wno-shorten-64-to-32 -Wno-undefined-bool-conversion -Wno-tautological-undefined-compare -std=c++11 -fno-exceptions -fno-rtti -nostdinc++ -isystem../../buildtools/third_party/libc++/trunk/include -isystem../../buildtools/third_party/libc++abi/trunk/include -fvisibility-inlines-hidden -Wnon-virtual-dtor -Woverloaded-virtual -c ../../api/audio_codecs/audio_encoder.cc -o obj/api/audio_codecs/audio_codecs_api/audio_encoder.o
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory
[6/2732] CXX obj/api/audio_codecs/ilbc...udio_encoder_ilbc/audio_encoder_ilbc.o
FAILED: obj/api/audio_codecs/ilbc/audio_encoder_ilbc/audio_encoder_ilbc.o 
../../third_party/llvm-build/Release+Asserts/bin/clang++ -MMD -MF obj/api/audio_codecs/ilbc/audio_encoder_ilbc/audio_encoder_ilbc.o.d -DNO_TCMALLOC -DCHROMIUM_BUILD -DCR_XCODE_VERSION=1020 -DCR_CLANG_REVISION=\"357692-1\" -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D_LIBCPP_ABI_UNSTABLE -D_LIBCPP_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS -D_LIBCPP_ENABLE_NODISCARD -DCR_LIBCXX_REVISION=358423 -D_DEBUG -DDYNAMIC_ANNOTATIONS_ENABLED=1 -DWTF_USE_DYNAMIC_ANNOTATIONS=1 -DWEBRTC_ENABLE_PROTOBUF=1 -DWEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE -DRTC_ENABLE_VP9 -DHAVE_SCTP -DWEBRTC_ARCH_ARM64 -DWEBRTC_HAS_NEON -DWEBRTC_LIBRARY_IMPL -DWEBRTC_NON_STATIC_TRACE_EVENT_HANDLERS=1 -DWEBRTC_POSIX -DWEBRTC_MAC -DWEBRTC_IOS -DABSL_ALLOCATOR_NOTHROW=1 -I../.. -Igen -I../../third_party/abseil-cpp -fno-strict-aliasing --param=ssp-buffer-size=4 -fstack-protector -fcolor-diagnostics -fmerge-all-constants -fcrash-diagnostics-dir=../../tools/clang/crashreports -Xclang -mllvm -Xclang -instcombine-lower-dbg-declare=0 -fcomplete-member-pointers -arch arm64 -fno-experimental-isel -Wno-builtin-macro-redefined -D__DATE__= -D__TIME__= -D__TIMESTAMP__= -no-canonical-prefixes -Wall -Werror -Wextra -Wimplicit-fallthrough -Wthread-safety -Wextra-semi -Wunguarded-availability -Wundeclared-selector -Wno-missing-field-initializers -Wno-unused-parameter -Wno-c++11-narrowing -Wno-unneeded-internal-declaration -Wno-undefined-var-template -Wno-ignored-pragma-optimize -O0 -fno-omit-frame-pointer -g2 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.2.sdk -stdlib=libc++ -miphoneos-version-min=10.0 -fvisibility=hidden -Wheader-hygiene -Wstring-conversion -Wtautological-overlap-compare -Wexit-time-destructors -Wglobal-constructors -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -Wc++11-narrowing -Wimplicit-fallthrough -Wthread-safety -Winconsistent-missing-override -Wundef -Wunused-lambda-capture -Wno-shorten-64-to-32 -Wno-undefined-bool-conversion -Wno-tautological-undefined-compare -std=c++11 -fno-exceptions -fno-rtti -nostdinc++ -isystem../../buildtools/third_party/libc++/trunk/include -isystem../../buildtools/third_party/libc++abi/trunk/include -fvisibility-inlines-hidden -Wnon-virtual-dtor -Woverloaded-virtual -c ../../api/audio_codecs/ilbc/audio_encoder_ilbc.cc -o obj/api/audio_codecs/ilbc/audio_encoder_ilbc/audio_encoder_ilbc.o
/bin/sh: ../../third_party/llvm-build/Release+Asserts/bin/clang++: No such file or directory
ninja: build stopped: subcommand failed.
suntongmiandeMacBook-Pro:src suntongmian$ 
```

## step 3

编译 WebRTC 库文件的方法有2种，分别为 ninja 命令行，python 脚本。

### 方法 1

使用 `ninja` 命令行编译，在终端执行命令

```
ninja -C out/ios framework_objc
```

生成的库文件在 `out/ios` 目录下。

### 方法 2

使用 python 脚本 `/src/tools_webrtc/ios/build_ios_libs.py` 编译，在终端执行命令

```
python tools_webrtc/ios/build_ios_libs.py --bitcode
```

生成的库文件在 `out_ios_lib` 目录下。

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

[12] [GN](https://gn.googlesource.com/gn/+/master/README.md)

[13] [Ninja](https://ninja-build.org/)

[14] [chromium中的GN构建系统](https://blog.csdn.net/mogoweb/article/details/73650218)

[15] [Chromium GN构建工具的使用](https://www.wolfcstech.com/2016/11/16/ChromiumGN%E6%9E%84%E5%BB%BA%E5%B7%A5%E5%85%B7%E7%9A%84%E4%BD%BF%E7%94%A8/)

[16] [【Git学习笔记】Git冲突：commit your changes or stash them before you can merge.](https://blog.csdn.net/liuchunming033/article/details/45368237)

