> # 添加广告 ads.txt 文件

添加 ~/depthloveBlog/themes/next/source/ads.txt 文件。该文件来至于 Google Adsense 网站下的个人账号。


> # 新建广告模版

新建 ~/depthloveBlog/themes/next/layout/_custom/google_adsense.swig 文件，加入广告代码

```
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<!-- BlogAd -->
<ins class="adsbygoogle"
     style="display:block"
     data-ad-client="ca-pub-2304335236058241"
     data-ad-slot="8084137562"
     data-ad-format="auto"
     data-full-width-responsive="true"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
```

新建 ~/depthloveBlog/themes/next/layout/_custom/head.swig 空白文件

新建 ~/depthloveBlog/themes/next/layout/_custom/header.swig 空白文件

新建 ~/depthloveBlog/themes/next/layout/_custom/sidebar.swig 空白文件

备注：不新建 head.swig，header.swig，sidebar.swig 这3个空白文档，在执行 hexo g 命令时会报错。

> # 插入广告

## 博客顶部广告

往 ~/depthloveBlog/themes/next/layout/_partials/head/head.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```
{# Export some HEXO Configurations to Front-End #}
<script id="hexo.configurations">
  var NexT = window.NexT || {};
  var CONFIG = {
    root: '{{ theme.root }}',
    scheme: '{{ theme.scheme }}',
    version: '{{ version }}',
    sidebar: {{ theme.sidebar | json_encode }},
    back2top: {{ theme.back2top.enable }},
    back2top_sidebar: {{ theme.back2top.sidebar }},
    fancybox: {{ theme.fancybox }},
    fastclick: {{ theme.fastclick }},
    lazyload: {{ theme.lazyload }},
    tabs: {{ theme.tabs.enable }},
    motion: {{ theme.motion | json_encode }},
    algolia: {
      applicationID: '{{ theme.algolia.applicationID }}',
      apiKey: '{{ theme.algolia.apiKey }}',
      indexName: '{{ theme.algolia.indexName }}',
      hits: {{ theme.algolia_search.hits | json_encode }},
      labels: {{ theme.algolia_search.labels | json_encode }}
    }
  };
</script>

{% if theme.custom_file_path.head %}
  {% set custom_head = '../../../../../' + theme.custom_file_path.head %}
{% else %}
  {% set custom_head = '../../_custom/head.swig' %}
{% endif %}
{% include custom_head %}

{% include '../../_custom/google_adsense.swig' %}
```

## 博客底部广告

往 ~/depthloveBlog/themes/next/layout/_partials/footer.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```
{% include '../_custom/google_adsense.swig' %}

<div class="copyright">{#
#}{% set current = date(Date.now(), "YYYY") %}{#
#}{% if theme.footer.beian.enable %}{#
#}  {{ next_url('http://www.beian.miit.gov.cn', theme.footer.beian.icp + ' ') }}{#
#}{% endif %}{#
#}&copy; {% if theme.footer.since and theme.footer.since != current %}{{ theme.footer.since }} – {% endif %}{#
#}<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love" id="animate">
    <i class="fa fa-{{ theme.footer.icon.name }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright || author }}</span>

  {% if config.symbols_count_time.total_symbols %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.count_total') + __('symbol.colon') }}</span>
    {% endif %}
    <span title="{{ __('symbols_count_time.count_total') }}">{#
    #}{{ symbolsCountTotal(site) }}{#
  #}</span>
  {% endif %}
```

## 侧边栏广告 

往 ~/depthloveBlog/themes/next/layout/_macro/sidebar.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```     
      {% if theme.back2top.enable and theme.back2top.sidebar %}
        <div class="back-to-top">
          <i class="fa fa-arrow-up"></i>
          {% if theme.back2top.scrollpercent %}
            <span id="scrollpercent"><span>0</span>%</span>
          {% endif %}
        </div>
      {% endif %}

      {% include '../_custom/google_adsense.swig' %}
      
    </div>
  </aside>
  {% if theme.sidebar.dimmer %}
    <div id="sidebar-dimmer"></div>
  {% endif %}
{% endmacro %}
```

## 文章广告

往 ~/depthloveBlog/themes/next/layout/_macro/post.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```        
      {% if not is_index and (post.prev or post.next) %}
        {% include '../_custom/google_adsense.swig' %}
        <div class="post-nav">
          <div class="post-nav-next post-nav-item">
            {% if post.next %}
              <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
                <i class="fa fa-chevron-left"></i> {{ post.next.title }}
              </a>
            {% endif %}
          </div>

          <span class="post-nav-divider"></span>

          <div class="post-nav-prev post-nav-item">
            {% if post.prev %}
              <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
                {{ post.prev.title }} <i class="fa fa-chevron-right"></i>
              </a>
            {% endif %}
          </div>
        </div>
      {% endif %}

      {% set isLast = loop.index % page.per_page === 0 %}
      {% if is_index and not isLast %}
        <div class="post-eof"></div>
      {% endif %}
    </footer>
  </div>
  {######################}
  {### END POST BLOCK ###}
  {######################}
  </article>

{% endmacro %}
```

```
          <!--/noindex-->
        {% else %}
          {% if post.type === 'picture' %}
            <a href="{{ url_for(post.path) }}">{{ post.content }}</a>
          {% else %}
            {{ post.content }}
          {% endif %}
        {% endif %}
      {% else %}
        {% include '../_custom/google_adsense.swig' %}
        {{ post.content }}
      {% endif %}
    </div>

    {% if theme.related_posts.enable and (theme.related_posts.display_in_home or not is_index) %}
      {% include '../_partials/post/post-related.swig' with { post: post } %}
    {% endif %}

    {#####################}
    {### END POST BODY ###}
    {#####################}
```

## 评论区广告

往 ~/depthloveBlog/themes/next/layout/_partials/comments.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```
  {% elif theme.gitment.enable %}
    <div class="comments" id="comments">
      {% if theme.gitment.lazy %}
        <div onclick="showGitment()" id="gitment-display-button">{{ __('gitmentbutton') }}</div>
        <div id="gitment-container" style="display: none"></div>
      {% else %}
        <div id="gitment-container"></div>
      {% endif %}
    </div>

  {% elif theme.valine.enable and theme.valine.appid and theme.valine.appkey %}
    <div class="comments" id="comments">
    </div>

  {% elif theme.gitalk.enable %}
    <div class="comments" id="gitalk-container">
    </div>

  {% endif %}

  {% include '../_custom/google_adsense.swig' %}

{% endif %}
```
