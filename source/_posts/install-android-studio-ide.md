title: Mac上安装Android Studio
date: 2015-10-09 09:48:38
tags:
- Android
---

　　Google在国内被墙，有关android开发的一些工具在Google上下载都需要使用VPN服务。我使用过一些免费与付费的VPN，想使用较好的服务质量就需要花点小钱，付费VPN中 [uuu vpn](http://v.uuu.net/) 很好用，有windows，Mac客户端，使用比较方便，代理服务稳定，快速，比 [green vpn](http://www.greenvpncn.com/) 好用多了，green vpn很烂，买过几次包月的套餐，向其客服吐槽过其VPN简直烂的让人无语，总之，对green vpn 没有什么好印象了。

<!-- more -->

### 一、使用VPN服务
　　具体使用什么VPN看个人喜好，我使用的是uuu vpn。在Mac上启用 uuu vpn，翻墙。
　　
### 二、在Google官网下载Android Studio
　　Android Studio 的官方下载地址为：[http://developer.android.com/sdk/index.html](http://developer.android.com/sdk/index.html)。我的系统是Mac，选择Mac版的Android Studio IDE。

　　下载android studio：

![下载进度](http://images2015.cnblogs.com/blog/719115/201510/719115-20151009102102393-1885681577.png)

　　下载后，下载页面出现一下安装提示信息 [Installing Android Studio](http://developer.android.com/sdk/installing/index.html?pkg=studio)，重要信息如下：

![安装步骤提示](http://images2015.cnblogs.com/blog/719115/201510/719115-20151009102135112-514568119.png)

　　在安装android studio 之前，必须安装 JDK 6 或者 JDK 的更高版本，只安装 JRE 是不够的。要开发 android 5.0 或更高的android系统版本程序，就必须安装 JDK 7。要知道自己的Mac系统上是否安装了 JDK ，在Mac终端执行命令 `javac -version`，如下：

![检查jdk安装信息](http://images2015.cnblogs.com/blog/719115/201510/719115-20151009103638831-972699102.png)

从图中的命令执行结果可知，Mac上安装的 JDK 的版本为 JDK 8 Update 40 。

　　如果检查到 JDK 没有安装，或者版本低于6，那么，就需要下载新版本的JDK，并安装。


　　
