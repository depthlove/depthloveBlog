---
title: 搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 port 被封
date: 2019-06-03 21:07:34
tags:
- VPN
categories:
- 工具
---

《搬瓦工搭建 ShadowSocks 翻墙（VPN）系列》

(1) [搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/)

(2) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/)

(3) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 port 被封]()

在上一篇 [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/) 谈到了如何解决 IP 被墙的问题，但没有提及端口 port 被封的问题。本文就来说一下 port 被封导致 VPN 服务无法使用的问题。

之前我在使用过程中，出现过 VPN 突然无法使用的问题。定位下来的原因是 IP 被墙了。其实更详细的原因是 IP 被墙，端口 port 被封。我用工具检测了 IP 地址、port 端口，检测结果是 IP 地址国内检测点超时，国外监测点正常，port 端口处于关闭状态。我在 [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/) 一文中只提到了更换 IP 的解决途径。为什么我没有提到要更换 port 端口呢？原因在于使用更换后的 IP 地址，也就是新的 IP 地址搭建 VPN 服务时，默认的 VPN 服务端口 port 跟以前搭建的 VPN 服务的默认端口 port 不一样，我每次搭建 VPN 服务的时候，都是使用提示的默认端口号 port，这让 port 端口被封导致 VPN 服务无法使用的问题没有暴露出来。

<!-- more -->

为什么要写这篇文章呢？起因是我写了 [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/) 之后，有同学遇到 VPN 服务无法使用，采用更换 IP 的策略重新搭建 VPN 服务后 VPN 服务仍然无法正常工作，最终定位的原因是 port 端口被封了，端口 port 处于关闭状态。在看了几个同学的留言交流信息后，我觉得有必要单独写一篇文章来记录下 port 端口被封导致 VPN 服务无法使用的问题。

# 一、IP 检测

在更换了新的 IP 地址后，我们要确定该 IP 地址是否正常可用。

首先，在终端上使用 `ping` 命令检测 IP 地址，看是否超时。在终端执行命令的格式如下

```
ping 111.11.111.111
```

其次，访问 [http://ping.chinaz.com/](http://ping.chinaz.com/) 检测 IP 地址的连通性，观察检测结果，如果国内国外的监测点的状态都是正常访问状态的话，说明新的 IP 地址是靠谱的。


# 二、port 检测

port 端口号本来是在搭建 VPN 服务的时候才出现的一个选项，用户可以使用默认的端口号或在其提示的范围内自己决定一个端口号。我一般都是选择的是提示的默认端口号，我在更换 IP 地址重新搭建 VPN 服务的过程中发现，不同 IP 地址在搭建 VPN 服务时提示的默认端口号是不一样的。

为谨慎起见，我们最好在重新搭建 VPN 服务时出现端口号提示的时候，检测下我们要使用的端口号。因为有的同学喜欢用某个固定的端口号。访问端口检测的网址 [http://tool.chinaz.com/port](http://tool.chinaz.com/port) 去检测端口是否可用，检查的结果为开启或者关闭中的一种。

备注：如果出现过 IP 被墙导致 VPN 服务无法使用的问题，那么我们在搭建 VPN 服务的时候，就不要使用和上次搭建一样的 port 端口号了。VPN 服务无法使用时，IP 肯定被墙了，port 也肯定被封了。所以，我们在更换 IP后，也要更换 port 号。举个例子更好理解一些，例子如下

更换 IP 前的 VPN 服务的配置信息

```
IP: 111.11.111.111
port: 11260
```

更换 IP 后的 VPN 服务的配置信息

```
IP: 222.22.222.222
port: 10404
```

总结一下，换 IP 了，端口号 port 也要跟之前的不一样。


# 三、搭建 VPN 服务

按照[使用搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/)一文中提到的步骤，重新搭建 VPN 服务。按照其中的步骤仔细操作，搭建的 VPN 服务肯定会正常运行。