---
title: 搬瓦工搭建 ShadowSocks 翻墙（VPN）- 更换密码
date: 2019-06-04 09:30:26
tags:
- VPN
categories:
- 工具
---

《搬瓦工搭建 ShadowSocks 翻墙（VPN）系列》

(1) [搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/)  
(2) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 IP 被墙](https://depthlove.github.io/2019/06/02/establish-vpn-server-02/)  
(3) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 解决 port 被封](https://depthlove.github.io/2019/06/03/establish-vpn-server-03/)
(4) [搬瓦工搭建 ShadowSocks 翻墙（VPN）- 更换密码]()

我没写一篇文章时，都要交待下写作的原因。交待下原因，透露出多的信息，会更好的发挥文章的价值。在 [搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/) 一文发布后不久，就收到了同学的留言“VPN 服务搭建完成后，想更换密码该怎么操作？”。请允许我过多的使用同学一词，因为我觉得这个叫法很亲切，谓之同学，乃共同进步之意。

刚开始看到这个留言的时候，我觉得这不是什么硬需求，毕竟密码设置这个东西在我们操作的时候肯定是在脑海中思考好了的。如果真的出现设置的密码不好记、密码太长、密码忘记了该怎么办呢？真的就需要重新再搭建一次 VPN 服务？有没有更好更简单的办法解决问题？

<!-- more -->

# 一、寻找解决问题的办法

我刚开始看到这个更换 VPN 服务密码的留言，我好长时间都没有回复。

首先，我对 ShadowSocks 翻墙这块涉及的东西并不是很熟悉，我掌握的东西也都是从网上看的一些教程获取的，涉及的范围不广。

其次，我认为这种更换密码的需求就不应该存在。为什么我们设置的密码想更换或者忘记了？说明我们在设置密码时，没有使用好记的密码，也没有将密码写在自己的备忘录中供后续查询。

最近刚好有点空闲，我的 VPN 服务的 IP 地址被墙了，就想起了这个事情。最开始我也在网络上查询了如何更换 `VPS VPN 更换密码 change/reset password` 等关键词，但并没有看到我想要的答案。可能大家都觉得这种问题不值得一提，遇到了重新操作一次 VPN 安装过程就行了。

网络上找不到直接的解决问题的线索，这时我们该怎么办？回归 VPN 安装过程中的提示信息。

# 二、实际动手解决问题

## 第一步：修改密码

在 [搬瓦工搭建 ShadowSocks 翻墙（VPN）](https://depthlove.github.io/2019/03/29/establish-vpn-server/) 一文中的 “三、安装 SSR 脚本” 步骤结束后的打印信息：

```
INFO: loading config from /etc/shadowsocks-python/config.json
2019-03-28 05:14:24 INFO loading libcrypto from libcrypto.so.10
Starting Shadowsocks success

Congratulations, Shadowsocks-Python server install completed!
```

看到 VPN 服务的配置信息是不是有点激动呢？有配置那是否意味着更改配置信息就能达到我们的目的呢？

在终端操作命令

```
vi /etc/shadowsocks-python/config.json
```

可以看到

```
{
"server":"0.0.0.0",
"server_port":11260,
"local_address":"127.0.0.1",
"local_port":1080,
"password":"123456",
"timeout":300,
"method":"aes-256-cfb",
"fast_open":false
}
```

在看到 `password ` 后，我们可以试试修改 `password` 的值。编辑 `/etc/shadowsocks-python/config.json`，修改 `password` 的值为 12345678，保存退出。

## 第二步：重启 VPS 主机

上一步中，修改了 VPN 服务的配置文件中密码信息。但要想让新密码生效，就需要执行最关键的一步：**重启 VPS 主机**。重启之后，重新配置 ShadowSocks VPN 客户端软件中的信息，使用新的密码，就可以翻墙访问 Google 等服务了。
