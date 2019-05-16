---
title: 使用 tensorflow 学习梵高画作
date: 2017-01-19 19:32:28
tags:
- 机器学习
categories:
- 机器学习
---

配一台个人使用的深度学习机器大概会花费2万人民币，比如其中的核心部件英伟达 Titan X GPU 售价大概9000人民币左右，这个价格对于一般人还是略贵的。想深层次进入深度学习应用领域，花点钱是必须的。正所谓有投入才有产出。本人现在还没有入手深度学习机器的预算，所以使用 Mac Pro 利用 CPU 计算来玩玩简单点的深度学习项目。

我的 Mac Pro 配置为：

```
OS X EI Capitan
版本 10.11.6 (15G1212)
MacBook Pro（13 英寸，2015 年初期）
处理器 2.7 GHz Intel Core i5
内存 8 GB 1867 MHz DDR3
启动磁盘 Macintosh HD
图形卡 Intel Iris Graphics 6100 1536 MB
```

<!-- more -->

### 1. 在 Mac 上安装 Anaconda 软件

![Anaconda 软件界面](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119195435984-525274691.png)

### 2. 建立 tensorflow 的 conda 计算环境

这里提一下有关 python 版本的问题，现在最稳定最常用的 python 版本是 2.7 和 3.5。入门 python 的话，建议从 2.7 版本入手，然后再过渡到 python 3.x 版本。我这里选用 tensorflow 依赖的 python 版本为 2.7。

在 Mac 终端执行命令：

```
conda create -n tensorflow python=2.7
```
![conda 创建 tensorflow 空间](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119210947859-1111890790.png)

执行完命令后，可以看到

	#
	# To activate this environment, use:
	# > source activate tensorflow
	#
	# To deactivate this environment, use:
	# > source deactivate tensorflow
	#
	
在 Mac 终端执行命令 `source activate tensorflow` 可以激活名为 tensorflow 的 conda 计算环境，执行命令 `source deactivate tensorflow` 能关闭 conda 计算环境。

### 3. 运行名为 tensorflow 的 conda 计算环境

在 Mac 终端执行命令激活 conda 计算环境

```
source activate tensorflow
```

![激活 conda 计算环境](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119215425593-252567153.png)

命令执行完之后，终端最左边会出现 (tensorflow) ，说明名为 tensorflow 的 conda 计算环境被激活了。

### 4. 使用 pip 安装 tensorflow 深度学习框架

仍然是在 Mac 终端执行命令：

```
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/mac/tensorflow-0.8.0rc0-py2-none-any.whl
```

![pip 安装 tensorflow](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119220557046-2012970460.png)

安装过程中，出现以下错误提示，说明网络不好，或者需要使用 vpn 翻墙。多试几次就能安装成功了。
![安装超时，出错](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119220749421-424094784.png)

### 5. 验证 tensorflow 深度学习框架安装成功

在 Mac 终端执行命令，进入 python 环境

```
python
```

执行一个简单的 tensorflow 小程序来验证深度学习框架是否安装成功，小程序如下：

	import tensorflow as tf
	hello = tf.constant('Hello, TensorFlow!')
	sess = tf.Session()
	print sess.run(hello)

	a = tf.constant(10)
	b = tf.constant(32)
	print sess.run(a+b)

![执行 python 命令，运行 tensorflow 小程序](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119232634984-1600377688.png)

上面的小程序能正常运行，说明 tensorflow 深度学习框架安装成功了。此时，可以在软件 Anaconda 中查看名称为 tensorflow 的 conda 计算环境，如下图所示：

![Anaconda 中查看名称为 tensorflow 的 conda 计算环境](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119233341234-1329704415.png)

### 6. 加载 neural-style 神经网络训练代码

项目 neural-style 位于 github 上，地址为 [https://github.com/anishathalye/neural-style](https://github.com/anishathalye/neural-style)

创建或者选择一个文件夹来存放 neural-style 代码，使用 git clone 方式 download 代码，命令如下：

```
git clone https://github.com/anishathalye/neural-style.git
```

![下载 neural-style 代码](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119235126296-418324233.png)

项目 neural-style 会依赖 pillow，因此还需要安装 pillow，在终端执行命令：

```
pip install pillow
```

![安装 pillow](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119235240281-926099681.png)

### 7. 加载数据模型 

在终端执行命令：

```
wget http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat
```

 ![](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119235505140-1370501613.png)
 
 ![](http://images2015.cnblogs.com/blog/719115/201701/719115-20170119235528781-103216887.png)


使用 wget 下载数据模型太慢了，简直不能忍，imagenet-vgg-verydeep-19.mat 文件还挺大，有576M。时间就是生命，生命不该浪费在下载上，果断使用 `ctrl + c` 中断了 wget 下载，如果你能忍受 wget ，那你就用 wget 吧，反正也能下载，就是慢点。为了节约点时间，神奇的淘宝就要闪亮登场了，我在淘宝上先花了1毛钱买了一天的迅雷会员，可是并没有像商家说的秒发账号密码。为了节约时间，果断地又花了1块钱买了一个月的迅雷会员，嗯，这家发货挺快的，接下来就是用迅雷加速下载链接 [http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat](http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat)

imagenet-vgg-verydeep-19.mat 下载完成后，将其移动到 neural-style 根目录下，如下图所示：

![数据模型存放路径](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120001629546-441644004.png)

### 8. 开启深度学习之梵高的大门

进入 neural-style 目录，将需要处理的图片 nuc.jpg 放入目录 examples 中。nuc_output.jpg 为处理之后输出的文件名称。如果要处理图片 xyz.jpg 就将其放入 目录 examples 中，至于输出文件的名称可以随便设置，比如可以设置为 xyz_output.jpg。

在终端执行命令 A

```
python neural_style.py --content ./examples/nuc.jpg --styles ./examples/1-style.jpg --output ./examples/nuc_output.jpg --iterations 1500
```

其中，1-style.jpg 为梵高大师画作，也就是需要学习的对象，这里也可以改为梵高的 2-style1.jpg 或 2-style2.jpg 来作为学习的对象。--iterations 1500 表示迭代次数，如果用笔记本或者普通的台式机就减少迭代次数，因为机器运算太慢了，1500 次迭代不知道要何年何月才能执行完。`但是迭代次数在 1000 至 2000 之间处理的效果会比较理想`。

在我的 Mac Pro 上设置的迭代次数为 100 次，得到处理后的图片效果还可以。需要提一下，在我的 Mac pro （配置前面已经给出） 上迭代1次大概会花费3分钟，迭代 100 次需要花费 5小时，毕竟是基于 CPU 计算，运算慢。要是有台 GPU 机器该有多爽，哈哈，想想而已，嘻嘻。

![开始迭代](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120004050156-1048917434.png)

哦呵，出现了 error 提示，原因在于没有安装 scipy。在终端执行命令安装 scipy

```
pip install scipy
```

![安装 scipy](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120004101859-1719031783.png)

将迭代次数改为 100次，再次执行命令 A

![迭代 100次](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120004131406-901903984.png)

![迭代 100次 续](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120004140046-1598886231.png)

OK，到此，所有步骤结束，我们可以看看经过深度学习处理之后的图片效果了。

### 9. 查看处理后的图片效果

进入 neural-style/examples 目录，查看目标图片 nuc_output.jpg 

![](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120004950328-576212904.png)

梵高大师画作 1-style.jpg 如下：

![梵高画](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120005037984-1130888407.jpg)

选取了一张我就读过的大学的图书馆照片 nuc.jpg 作为需要处理的图片，如下：

![原图，我的大学校园图书馆](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120005049062-618427893.jpg)

迭代 100次，学习梵高大师画风后得到的处理后的目标图片 nuc_output.jpg，如下：
![梵高画风的大学图书馆](http://images2015.cnblogs.com/blog/719115/201701/719115-20170120005104421-824057092.jpg)


##### 参考文献：

[http://wiki.jikexueyuan.com/project/tensorflow-zh/get_started/os_setup.html](http://wiki.jikexueyuan.com/project/tensorflow-zh/get_started/os_setup.html)

[https://github.com/anishathalye/neural-style](https://github.com/anishathalye/neural-style)

迭代 1次，2次，10次，20次，30次，40次，100次输出的图片合成的 GIF 图，如下

<img src="http://images2015.cnblogs.com/blog/719115/201701/719115-20170120013703062-275928298.gif" width="240" height="240" />

