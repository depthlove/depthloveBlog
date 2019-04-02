title: 笔谈cocoapods的安装与使用
date: 2015-05-11 16:09:05
tags: 
- iOS
---
　　因为要重构播放器库，所以就需要参考网上的开源项目，在播放器开源项目这块，kxmovie开源项目是值得参考的一个项目。在github下载下来后，运行该工程，发现其用到了cocoapods来管理第三方库，以前我做项目都是将第三方库直接下载然后将源文件导入到工程，这种做法有其好处也存在一定的弊端，好处是便于项目的维护，方便的知道过去使用的第三方库是个什么情况，还可以根据实际需求修改，弊端就是第三方库的更新需要自己下载最新的再将旧的替换（手动更新）。通过cocoapods来管理第三方库，可以获取到最新的第三库将其引用到项目中，而且不需要自己手动去添加该第三方库的依赖库，虽然cocoapods用起来方便，但是也不一定全好，因为项目运行链接第三方库的时候，比如之前自己改过cocoapods引用进来的第三方库，这时就悲剧了，加载的第三方库是重新从网络上获取的，网上一些开发者也提到了，通过cocoapods管理项目中的第三方库不便于项目回滚。所以，是否选择cocoapods要根据实际情况来定。

<!-- more -->

　　要使用cocoapods，对于之前没有安装过cocoapods的开发者来说，首先就是要在Mac上安装cocoapods，在Mac终端执行命令 **sudo gem install cocoapods**，执行结果如下
　　
![终端执行结果](http://images.cnitblog.com/blog2015/499497/201505/111557198605907.png)

　　但是没有发现cocoapods源，因为ruby的软件源rubygems.org使用的亚马逊的云服务，被墙了，需要更新一下ruby的源，使用其他能支持的源---->国内淘宝的源：

	gem sources --remove https://rubygems.org/

	gem sources -a http://ruby.taobao.org/

	gem sources -l

　　执行上面的命令结果如下：

![淘宝源执行结果](http://images.cnitblog.com/blog2015/499497/201505/111601220012200.png)

　　现在，更新源成功了，可以进行安装了，继续在Mac终端执行命令 **sudo gem install cocoapods**，执行结果如下：

![终端执行结果](http://images.cnitblog.com/blog2015/499497/201505/111605066427802.png)

.............

.............

　　接下来在Mac终端输入以下命令：**pod setup**　　

注意：This process will likely take a while as this command clones the CocoaPods Specs repository 

into ~/.cocoapods/ on your computer.

![终端执行结果](http://images.cnitblog.com/blog2015/499497/201505/111655319395424.png)

 　　来看看我们安装的cocoapods的版本信息，在Mac终端上执行命令 **pod --version**，执行结果如下：
 
![终端执行结果](http://images.cnitblog.com/blog2015/499497/201505/111608117677679.png)

　　OK，cocoapods安装成功了。

　　若要卸载cocoapods， 就在Mac终端执行命令 **sudo gem uninstall cocoapods**

　　参考文章：[用CocoaPods做iOS程序的依赖管理](http://www.devtang.com/blog/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/)

　　　　　　　[iOS.CocoaPods.0](http://www.cnblogs.com/cwgk/p/3370949.html)

　　　　　　  [OS X升级到10.10之后使用pod出现问题的解决方法](http://blog.csdn.net/dqjyong/article/details/37958067)

　　　　　　  [osx升级到10.10后，用pod install报错最终解决办法](http://blog.csdn.net/feixiang_song/article/details/40392629?utm_source=tuicool)

　　cocoapods安装好了，接下来就该用它来做事了。使用CocoaPods管理第三方库的例子如下：

　　使用Xcode,在工程根目录下，新建立一个空白的Podfile文档，然后在里面添加以下内容

	platform:ios,'6.0'
	pod 'FMDB', '~> 2.0'
	pod 'AFNetworking', '~> 1.1.0'
	pod 'JSONKit','~>1.4'
	
 　  保存，然后配置工程， 在系统终端中，使用cd命令切换到项目根目录下，输入命令： **pod install**

　　执行完之后，CocoaPods在工程目录下创建了一个文件夹“Pods”，该文件夹存放所有依赖的库，另外还创建了一个.xcworkspace文件，配置完之后需使用.xcworkspace文件打开工程。

　　参考文章：[CocoaPods安装和使用教程](http://www.cnblogs.com/crazypebble/p/3597419.html)

　　　　　　  [iOS系列译文：深入理解 CocoaPods](http://jishu.zol.com.cn/207731.html)

 

　　对于kxmoive这个工程，它使用cocoapods就引用了一个库，对于我而言，就因为引用一个库反复折腾cocoapods，肯定不爽，浪费时间。所以，我就想删掉kxmoive工程中cocoapods的所有相关东西。但是，删除cocoapods后，出现了如下错误：

　　**diff: /../Podfile.lock: No such file or directory diff: /Manifest.lock: No such file or directory error: The sandbox is not in sync with the Podfile.lock. Run 'pod install' or update your CocoaPods installation.**

　　我参考文章 [从工程中删除Cocoapods](http://blog.csdn.net/freedom2028/article/details/10244819) ，顺利解决了这个问题。对于上面的这个报错，当工程中有使用cocoapods的时候，运行项目也可能会出现这个问题，那就按照报错提示，重新更新pod，即在Mac终端执行pod install，参考文章 [Xcode工程使用CocoaPods管理第三方库新建工程时出现错误](http://www.cnblogs.com/ios-wmm/p/3360958.html)


