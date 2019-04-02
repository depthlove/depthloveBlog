---
title: 使用 SRS 在 VPS 上搭建流媒体服务器
date: 2019-04-02 11:09:20
tags:
- 音视频处理
- 服务器开发
---

闲话少说，直接步入正题。

### 一、登陆远程服务器
我使用的是 MacBook Pro 笔记本，在 MacBook Pro 笔记本上的终端输入命令 ssh root@IP地址 -p ssh端口

```
ssh root@111.11.111.111 -p 1111
```

其中，IP 地址和 SSH 端口换成你自己的 VPS 信息。

### 二、下载 SRS 源码
在终端执行命令下载 SRS 源码

```
git clone https://github.com/ossrs/srs
```

### 三、编译 SRS 
进入 srs/trunk 目录

```
cd ./srs/trunk
```

在终端执行下面的命令编译 SRS

```
./configure && make
```

<!-- more -->

### 四、修改配置文件

我没有对 **./conf/srs.conf** 文件进行修改，使用的是默认配置。使用默认的配置，可跳过此步，直接进入下一步 **“五、启动 SRS”** 的操作。如果想改 vhost 或其它，就执行下面的操作。

```
vi ./conf/srs.conf 
```

srs.conf 配置文件的默认参数为

```
# main config for srs.
# @see full.conf for detail config.

listen              1935;
max_connections     1000;
srs_log_tank        file;
srs_log_file        ./objs/srs.log;
http_api {
    enabled         on;
    listen          1985;
}
http_server {
    enabled         on;
    listen          8080;
    dir             ./objs/nginx/html;
}
stats {
    network         0;
    disk            sda sdb xvda xvdb;
}
vhost __defaultVhost__ {
}
```

### 五、启动 SRS
启动 SRS 服务

```
./objs/srs -c conf/srs.conf
```

### 六、下载 FFmpeg
下载 FFmpeg

```
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg
```

### 七、编译 FFmpeg
进入目录 ffmpeg

```
cd ffmpeg
```

编译 FFmpeg

```
./configure && make
```

如果出现错误：**nasm/yasm not found or too old. Use --disable-x86asm for a crippled build.**，就需要安装 yasm，并再次执行 ./configure && make 命令。如果未出错，跳过下面的操作直接进行下一步：**八、FFmpeg 推流** 的操作。

从 yasm 的版本列表 [http://www.tortall.net/projects/yasm/releases](http://www.tortall.net/projects/yasm/releases) 中找到合适的平台版本，通过以下命令安装 yasm

```
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz

```

```
tar zxvf yasm-1.3.0.tar.gz
```

```
cd yasm-1.3.0
```

```
./configure
```

```
make && make install
```

再次进入目录 ffmpeg 执行命令

```
./configure && make
```

### 八、FFmpeg 推流
使用 scp 命令上传文件到远程服务器上。scp 的使用见我的文章 [使用 live555 在 VPS 上搭建流媒体服务器](https://depthlove.github.io/2019/03/30/use-live555-establish-server-on-vps)

```
./ffmpeg -re -i ../ForBiggerFun.mp4 -f flv -y rtmp://111.11.111.111/live/teststreaming
```

其中，ForBiggerFun.mp4 视频文件在目录 ffmpeg 的上一层目录中。

### 九、播放视频流

使用 VLC 或者 ffplay 播放 rtmp 视频流：**rtmp://111.11.111.111/live/teststreaming**

### 参考文献

[https://github.com/ossrs/srs/wiki](https://github.com/ossrs/srs/wiki)