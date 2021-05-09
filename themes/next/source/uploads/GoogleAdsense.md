> # 前提

下面所有的用 {% include '../_custom/google_adsense.swig' %} 的地方，都用广告代码替换，避免 `hexo g` 报错，即使用

```
<!-- Google Ads -->
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
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

或者广告的内嵌模式代码

```
<!-- Google Ads Embed -->
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-2304335236058241"
     data-ad-slot="8930971915"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
```

> # 添加广告 ads.txt 文件

添加 ~/depthloveBlog/themes/next/source/ads.txt 文件。该文件来至于 Google Adsense 网站下的个人账号。


> # 新建广告模版

新建 ~/depthloveBlog/themes/next/layout/_custom/google_adsense.swig 文件，加入广告代码

```
<!-- Google Ads -->
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
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

新建 ~/depthloveBlog/themes/next/layout/_custom/google_adsense_embed.swig 文件，加入广告代码

```
<!-- Google Ads Embed -->
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<ins class="adsbygoogle"
     style="display:block; text-align:center;"
     data-ad-layout="in-article"
     data-ad-format="fluid"
     data-ad-client="ca-pub-2304335236058241"
     data-ad-slot="8930971915"></ins>
<script>
     (adsbygoogle = window.adsbygoogle || []).push({});
</script>
```

> # 插入广告

## 侧边栏广告 

往 ~/depthloveBlog/themes/next/layout/_macro/sidebar.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```     
      {%- if theme.back2top.enable and theme.back2top.sidebar %}
        <div class="back-to-top motion-element">
          <i class="fa fa-arrow-up"></i>
          <span>0%</span>
        </div>
      {%- endif %}

      <!-- Google Ads -->
      <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
      <ins class="adsbygoogle"
          style="display:block"
          data-ad-client="ca-pub-2304335236058241"
          data-ad-slot="8084137562"
          data-ad-format="auto"
          data-full-width-responsive="true"></ins>
      <script>
          (adsbygoogle = window.adsbygoogle || []).push({});
      </script>

    </div>
  </aside>
  <div id="sidebar-dimmer"></div>
{% endmacro %}
```

## 文章广告

往 ~/depthloveBlog/themes/next/layout/_macro/post.swig 引入 google_adsense.swig 文件，引入方式为 {% include '../_custom/google_adsense.swig' %}

```
      {% else %}

        <!-- Google Ads Embed -->
        <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
        <ins class="adsbygoogle"
            style="display:block; text-align:center;"
            data-ad-layout="in-article"
            data-ad-format="fluid"
            data-ad-client="ca-pub-2304335236058241"
            data-ad-slot="8930971915"></ins>
        <script>
            (adsbygoogle = window.adsbygoogle || []).push({});
        </script>

        {{ post.content }}
      {%- endif %}
    </div>

    {#####################}
    {### END POST BODY ###}
    {#####################}
```