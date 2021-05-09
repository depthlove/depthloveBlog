## 文章置顶功能

修改 ~/depthloveBlog/themes/next/layout/_macro/post.swig

在 

```
{%- if post.description and (not theme.excerpt_description or not is_index) %}
	<div class="post-description">{{ post.description }}</div>
{%- endif %}
```

后面添加代码

```
{% if post.top %}
	<i class="fa fa-thumb-tack"></i>
	<font color=green>置顶</font>
	<span class="post-meta-divider">|</span>
{% endif %}
```