---
title: 搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙
date: 2019-06-02 15:22:41
tags:
- VPN
categories:
- 工具
---

《搬瓦工搭建 ShadowSocks 翻墙（VPN）系列》

(1) [搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/)  
(2) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/)  
(3) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 port 被封](https://depthlove.github.io/2019/06/03/establish-vpn-server-03/)

[使用搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/) 一文中写了如何搭建 VPN 翻墙工具，但对于可能出现的问题没有提及。本文要说的是 VPN 服务所在的主机 IP 被墙后导致 VPN 服务无法使用的问题。

事情经过是这样的，今天我想使用 VPN 服务访问 Google 的服务，发现 [google.com](google.com) 响应超时。有点想不通，因为前几天 VPN 服务可以正常使用。出现这种问题，那就需要排查问题所在了。

# 一、排查问题

（1）访问 [搬瓦工 (BandwagonHost)](https://bwh88.net) 主页，登录之后，查看主机的运行状态。

结果：主机处在正常运行中。

<!-- more -->

（2）Mac 终端下通过 `ssh` 命令访问主机

在终端输入命令 **ssh root@IP地址 -p ssh端口**，其中 IP 地址和 SSH 端口换成你自己的 VPS 信息

```
ssh root@111.11.111.111 -p 1111
```

结果：多次尝试都表现为超时

（3）Mac 终端下使用 `ping` 命令检查 IP 地址的连通性

```
ping 111.11.111.111
```

结果：多次尝试都表现为超时，丢包率 100%

（4）Mac 终端下使用 `ping` 命令访问 `baidu.com`

```
ping baidu.com
``` 

结果：正常访问，丢包率为 0.0%

在这种情况下，我百度了下 `vps ssh 无法连接`，浏览了几篇文章后，确定了问题所在 **IP 被墙**。

# 二、检测 IP 地址被墙

访问网址 [http://ping.chinaz.com](http://ping.chinaz.com)，输入要检测的 IP 地址。

（1）如果国内、国外监测点都超时，那么该 IP 地址被墙的可能性较小，可以试试开机或者重启 VPS，或联系 VPS 供应商的客服。 

（2）如果国内监测点超时，国外监测点正常，那么就可以判定该 IP 地址被墙了。


# 三、解决 IP 地址被墙

（1）登陆[搬瓦工 (BandwagonHost)](https://bwh88.net) 主页

（2）我用的 **付费换 IP** 的模式。访问 [https://bwh88.net/ipchange.php](https://bwh88.net/ipchange.php)，费用为 8.79 美金，邮箱会收到供应商的邮件，根据邮件中的说明，点击付费连接，完成付费。付费方式支持支付宝、微信。

备注：个人建议使用 **付费换 IP** 的模式。**免费换 IP** 模式的网址为 [https://kiwivm.64clouds.com/main-exec.php?mode=blacklistcheck](https://kiwivm.64clouds.com/main-exec.php?mode=blacklistcheck)，我操作的时候，该网址提示 “This feature is disabled while we work on improving the accuracy of testing.” 说明无法使用免费换 IP 的服务。

（3）费用支付完成后，等十几分钟会收到 IP 地址更换成功的邮件。访问[搬瓦工 (BandwagonHost)](https://bwh88.net) 主页，进入个人购买的 VPS 控制面板主页，就可以看到主机的 IP 地址被更换了。

（4）按照[使用搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/)一文中提到的步骤，重新搭建 VPN 服务。

# 参考文献

[VPS能Ping但是SSH无法连接](https://server.zzidc.com/fwqcjwt/2579.html)  
[怎样检查搬瓦工IP被墙](https://www.banwago.com/1265.html)  
[#教程# 判断 IP 是否被墙及 VPS 无法连接的解决办法](https://www.vultrcn.com/4.html)  
[消息：搬瓦工VPS，IP被zzz，免费更换IP和收费更换IP](https://www.zhujiceping.com/30098.html)

