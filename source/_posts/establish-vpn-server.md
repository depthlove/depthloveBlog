---
title: 使用搬瓦工搭建 ShadowSocks 翻墙（VPN）
date: 2019-03-29 13:41:45
tags:
- 工具
---

为了查询资料的便利性，大部分时候需要使用 Google 浏览器，但是国内除了高校能默认支持访问 Google 的服务外，基本所有人想使用 Google 的服务都需要借助 [虚拟专用网 VPN (Virtual Private Network) ]([https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF](https://zh.wikipedia.org/wiki/%E8%99%9B%E6%93%AC%E7%A7%81%E4%BA%BA%E7%B6%B2%E8%B7%AF)
) 工具。以前使用过一些 VPN 服务提供商提供的服务，出现过用了一段时间就使用不了了、服务不稳定、连接后访问网络资源慢，还有的干脆就无法使用。比如我花了 79 美金买过 NordVPN 的服务，网上的口碑和排名很靠前的。事实上真是花钱买烦恼，99%的概率连不上 NordVPN 服务，即使碰运气连上去了，但网速差的让人吐血。为这个事，与 NordVPN 的技术支持来往过好多封英文邮件，最终还是没有解决连不上服务器的问题。在国内想使用 Google 服务查询资料真是痛苦。搞笑的是，2018年12月初去韩国济州岛玩，在济州岛使用 NordVPN 服务倒是 99%以上概率连上服务器，网速也还可以。泪崩，在 NordVPN 上花的钱彻底打水漂了。好在工作所在公司提供了 VPN 服务，就一直使用到现在。

为能正常使用 Google 的资源以及考虑到数据访问的私密性，就开始考虑搭建一个私人的 VPN 服务。查询了一些资料，找到了 [搬瓦工 (BandwagonHost)](https://bwh88.net) 。以下是搭建的流程：

<!-- more -->

####  一、购买主机服务 VPS
##### 参考该文的购买流程
[搬瓦工(BandwagonHost) 一键搭建ShadowSocks翻墙教程](https://www.iqiqi.org/banwagong-vps-setup-shadowsocks)

#### 二、登陆 VPS
##### 参考该文的登陆搬瓦工的 VPS 的流程
[Windows/Mac/Linux如何SSH远程连接/登陆搬瓦工](https://www.bwgyhw.cn/bandwagonhost-ssh-login/?utm_source=textarea.com&utm_medium=textarea.com&utm_campaign=article)

我使用的 MacBook Pro，以下为 Mac 系统上的 VPS 登陆流程：

在终端输入命令 **ssh root@IP地址 -p ssh端口**，其中 IP 地址和 SSH 端口换成你自己的 VPS 信息

```
ssh root@111.11.111.111 -p 1111
```

#### 三、安装 SSR 脚本
##### 参考该文的 Shadowsocks 安装流程
[搬瓦工(BandwagonHost)取消了一键安装Shadowsocks后，最新搬瓦工手动安装SS教程！](https://www.iqiqi.org/bandwagonhost-install-shadowsocks)

第一步：等到出现 **root@host ~** 字样，执行命令

```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
```

**注意 (warning) : 国外服务器运行脚本时容易出错，如出现错误提示 bash: wget: command not found，可以请在先执行 yum -y install wget 命令。成功后，再执行上面的命令。如果没有出现提示错误，请略过。**

第二步：等待上一步的命令执行结束后，继续执行命令

```
chmod +x shadowsocks-all.sh
```

第三步：等待上一步的命令执行结束后，继续执行命令

```
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

第四步：根据需要选择，不懂的话直接选1，或者默认回车。下面会提示你输入你的 SS SERVER 的密码和端口。不输入就是默认。跑完命令后会出来你的 SS 客户端的信息。

```
Which Shadowsocks server you’d select:
1) Shadowsocks-Python
2) ShadowsocksR
3) Shadowsocks-Go
4) Shadowsocks-libev
Please enter a number (Default Shadowsocks-Python):1

You choose = Shadowsocks-Python

Please enter password for Shadowsocks-Python
(Default password: teddysun.com):123456

password = 123456

Please enter a port for Shadowsocks-Python [1-65535]
(Default port: 11260):11260

port = 11260
```

第五步：特别注意，由于 iPhone 端的的 wingy 目前只支持到 cfb，所以我们选择 aes-256-cfb，即7，回车。

第六步：当我们看到 Congratulations, Shadowsocks-Python server install completed! 时，则证明我们已经成功安装了 SS。请立即将这些信息复制下来加以保存，我们就会用到这几个比较重要的信息：主机服务器IP地址、端口号、密码和加密方式。上面的命令全部回车执行后，如果没有报错，即为执行成功，出现确认提示的时候，输入 y 后，回车即可。

这样的话我们就在搬瓦工 VPS 主机上完成了 SS 的手动安装，记录保存好你的上述信息：Server IP、Server Port、Password、Encryption Method，我们就可以在不同的设备终端找到相应的 SS 进行安装设置使用了。

```
INFO: loading config from /etc/shadowsocks-python/config.json
2019-03-28 05:14:24 INFO     loading libcrypto from libcrypto.so.10
Starting Shadowsocks success

Congratulations, Shadowsocks-Python server install completed!
Your Server IP        :  111.11.111.111
Your Server Port      :  11260
Your Password         :  123456
Your Encryption Method:  aes-256-cfb

Your QR Code: (For Shadowsocks Windows, OSX, Android and iOS clients)
ss://xxxxxxxxxxxxxxxxx
Your QR Code has been saved as a PNG file path:
/root/shadowsocks_python_qr.png

Welcome to visit: https://teddysun.com/486.html
Enjoy it!
```

#### 四、使用 Shadowsocks 终端体验 VPN 服务

根据设备类型，下载对应的平台软件，并设置好参数就可以畅享 VPN 服务了。

Windows：[Github链接地址](https://github.com/shadowsocks/shadowsocks-windows/releases)

Mac：[Github链接地址](https://github.com/yangfeicheung/Shadowsocks-X/releases)

Android：[Github链接地址](https://github.com/shadowsocks/shadowsocks-android/releases)

iPhone：Kite Ass Proxy：[APP Store链接地址](https://itunes.apple.com/cn/app/kite-ss-proxy/id1346595633?mt=8)、
FirstWingy：[APP Store链接地址](https://itunes.apple.com/cn/app/firstwingy/id1316416848?mt=8)、
SuperWingy：[APP Store链接地址](https://itunes.apple.com/cn/app/superwingy/id1290093815?mt=8)

我要在 Mac 和 iPhone 上使用，我下载了上面的 Mac 版本，但是没有下载上面的 iPhone 版本，iPhone 版本我用的是 [Sockswitch](https://itunes.apple.com/us/app/sockswitch-shadowsocks-client/id1453207024?mt=8)



