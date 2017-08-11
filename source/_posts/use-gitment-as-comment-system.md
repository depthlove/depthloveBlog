---
title: 使用 gitment 制作 GitHub 博客的评论系统
date: 2017-08-12 00:31:13
tags:
- 工作
- hexo
---

多说评论系统在2017年6月1日关闭服务后，对于自建博客该使用哪款评论系统我犯愁了。我仔细对比了国内的一些评论系统，发现没有一款能比得上多说。虽然我之前的多说评论在导出时发生了数据错乱以至于数据无法导进新的评论系统，但是我从内心底对维护多说服务的技术人员表示认可。在知道多说即将关闭服务之后，我立即就选用了 Disqus。Disqus 真的很难用，一是需要翻墙，二是可视化界面做的太糟糕。不想在评论系统上大费周折，就将就用到了现在。终于忍无可忍，搜索了些资料发现了基于 GitHub issue 的 [gitment](https://github.com/imsun/gitment) 和 [gitalk](https://github.com/gitalk/gitalk) 两款评论插件。经过比较我选用了 [gitment](https://github.com/imsun/gitment)。

<!-- more -->

[gitment](https://github.com/imsun/gitment) 和 [gitalk](https://github.com/gitalk/gitalk) 这两款评论插件对于如何部署都没有说的很清晰。建议参考
[gitment readme](https://github.com/imsun/gitment/blob/master/README.md) 和 [Add Gitment Support](https://github.com/iissnan/hexo-theme-next/pull/1634/files)，即可部署成功。

本人博客基于 [github托管平台](https://github.com/) + [hexo博客框架](https://hexo.io) + [next博客主题](https://github.com/iissnan/hexo-theme-next) + [gitment评论插件](https://github.com/imsun/gitment) 资源构建。  

<p align="right">二〇一七年八月十二日，北京</p>

