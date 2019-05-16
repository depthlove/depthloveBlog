---
title: Mac搭建hexo博客
date: 2015-06-12 16:16:31
tags: hexo
---

## 一、安装git

#### 启动Mac终端，在终端执行命令

	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	brew install git

## 二、安装Node.js

#### nvm (Node Version Manager)，详见官方介绍：https://github.com/creationix/nvm#node-version-manager

<!-- more -->

在终端执行命令

	git clone git://github.com/creationix/nvm.git ~/.nvm

	cd /Users/dev.temobi/.nvm  （备注：/Users/dev.temobi/.nvm 是执行上一条命令的结果显示.nvm所在的路径）

	sh install.sh
	
#### 补充说明：对于Mac系统而言，可以跳过步骤一、步骤二，直接去node.js官网[https://nodejs.org/en/#download](https://nodejs.org/en/#download)下载软件，然后安装到Mac电脑上，node.js 就成功安装到了电脑上了，采用这种方法更简单，更直接。


## 三、安装hexo

在终端执行命令
	
	npm install -g hexo

#### 创建文件夹，根据自己实际情况，文件夹名可以任取，文件夹的路径可以选择你想放文件夹的路径。
我创建的文件夹为 ZZ_HexoBlog，路径为 /Users/dev.temobi/Desktop/sunmmMainPrj/ZZ_HexoBlog

进入文件夹ZZ_HexoBlog所在路径，在终端执行命令

	cd /Users/dev.temobi/Desktop/sunmmMainPrj/ZZ_HexoBlog

继续执行命令

	hexo init

	npm install

现在已经搭建起本地的hexo博客了。

执行命令

	hexo generate

	hexo server

然后到浏览器输入 http://0.0.0.0:4000/ 就可以预览博客了

## 四、部署hexo博客到github

#### 在自己的github账号中创建Repository

Repository name需要符合username.github.io的命名规则。比如我的Github账号是depthlove，我就要创建名为depthlove.github.io 的仓库。

#### 获取自己的Repository地址

我的为 https://github.com/depthlove/depthlove.github.io.git

#### 修改_config.yml文件

在终端上执行命令 

	vim _config.yml

找到 

	deploy:
	  type:

修改为：

	deploy:
   	  type: git
   	  repo: https://github.com/depthlove/depthlove.github.io.git
	  branch: master

保存退出

在终端执行命令 ls -al ~/.ssh，查看是否已经有SSH keys，如果之前在该电脑上使用过git管理过代码，结果是~/.ssh中会存在 id_rsa id_rsa.pub known_hosts 三个文件

在终端继续执行命令 

	ls -al ~/.ssh

若之前没有使用过git，该目录就是空的。有用过git管理项目结果如下

	total 32
	drwx------   5 dev.temobi  staff   170  6  8 17:00 .
	drwxr-xr-x+ 69 dev.temobi  staff  2346  6 12 13:47 ..
	-rw-------   1 dev.temobi  staff  1675  6  8 16:46 id_rsa
	-rw-r--r--@  1 dev.temobi  staff   399  6  8 17:04 id_rsa.pub
	-rw-r--r--   1 dev.temobi  staff  1593  6  8 18:27 known_hosts

执行命令 
	
	ssh-keygen -t rsa -C "depthlove@163.com"  

depthlove@163.com 是注册github账号时所用的邮箱


执行上面的命令后，会出现一些提示，什么都不用管，直接回车，再回车

继续输入命令

	ssh-agent -s

结果为

	SSH_AUTH_SOCK=/var/folders/0r/y1__8yjx579743zfttfrflsr0000gq/T//ssh-a9zU09oKAnpw/agent.17852;
	export SSH_AUTH_SOCK;
	SSH_AGENT_PID=17853; export SSH_AGENT_PID;
	echo Agent pid 17853;

继续输入命令 

	ssh-add ~/.ssh/id_rsa

结果为

	Identity added: /Users/dev.temobi/.ssh/id_rsa (/Users/dev.temobi/.ssh/id_rsa)

如果执行ssh-add ~/.ssh/id_rsa 出错，就输入以下指令：

	eval `ssh-agent -s`

	ssh-add

现在就成功生成了 SSH keys。

#### 把SSH keys添加到github账户中。


前往文件夹 ~/.ssh，用文本编辑器打开文件id_rsa.pub，复制其中的内容，然后粘贴到github add SSH keys的文本框中。操作完之后，github会要求输入github的登陆密码，输入完密码就成功添加了 SSH keys。

若还不放心，还可以通过 ssh -T git@github.com 命令查看SSH keys是否添加成功，继续在终端执行命令
	
	ssh -T git@github.com

结果如下

	Are you sure you want to continue connecting (yes/no)?yes // 输入yes
	Warning: Permanently added the RSA host key for IP address '192.xx.xxx.xxx’ to the list of known hosts.
	Hi depthlove! You've successfully authenticated, but GitHub does not provide shell access.

到这里准备工作都已做好，现在就是部署了。

继续在终端执行命令
	
	hexo generate
	
	hexo deploy

结果出现错误

	ERROR Deployer not found: git

此时，就要检查为什么出现这种错误了，解决方法是上网百度寻求解决方案，还有一种就是靠自己的经验了。我发现在我修改文件_config.yml的时候发现

	# Deployment
	## Docs: http://hexo.io/docs/deployment.html
	deploy:
  	type:
  	
发现有个word文档说明，而且我在执行hexo deploy出错，说明解决方法肯定在word链接中，结果是答案真的就在这里面。

在浏览器中输入 http://hexo.io/docs/deployment.html

然后按照网页上的文档说明，继续在终端上执行命令

	npm install hexo-deployer-git --save

最后在终端上执行命令 
	
	hexo deploy

OK，成功了！结果如下

	INFO  Deploying: git
	INFO  Setting up Git deployment...
	初始化空的 Git 版本库于 /Users/dev.temobi/Desktop/sunmmMainPrj/ZZ_HexoBlog/.deploy_git/.git/
	[master（根提交） e8f14ef] First commit
	 Committer: dev.temobi <dev.temobi@devtemobideMac-mini.local>
	您的姓名和邮件地址基于登录名和主机名进行了自动设置。请检查它们正确
	与否。您可以通过下面的命令对其进行明确地设置以免再出现本提示信息：

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

	设置完毕后，您可以用下面的命令来修正本次提交所使用的用户身份：

    git commit --amend --reset-author
	……
	……
	……
	create mode 100644 index.html
	create mode 100644 js/script.js
	delete mode 100644 placeholder
	Username for 'https://github.com': depthlove  // 输入自己的github用户名
	Password for 'https://depthlove@github.com':  // 输入自己的github密码
	To https://github.com/depthlove/depthlove.github.io.git
 	+ f0b2e27...cd56463 master -> master (forced update)
	分支 master 设置为跟踪来自 https://github.com/depthlove/depthlove.github.io.git 的远程分支 master。
	INFO  Deploy done: git

现在，就可以在浏览器中输入 http://depthlove.github.io ，访问我的hexo博客了


`注意：每次修改本地文件后，都要在hexo博客所在的目录下，执行命令 hexo generate 保存；想要上传文件到Github时，就应该在hexo博客所在的目录下先执行命令 hexo generate 保存之后，再执行命令 hexo deploy`

#### 补充

hexo现在支持更加简单的命令格式了，比如：

hexo g == hexo generate

hexo d == hexo deploy

hexo s == hexo server

hexo n == hexo new