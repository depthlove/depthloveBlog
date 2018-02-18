---
title: 阅读最多
date: 2018-02-18 11:01:20
type: "top"
comments: false
---

<div id="top"></div>
<script src="https://cdn1.lncld.net/static/js/av-core-mini-0.6.4.js"></script>
<script>AV.initialize("I0MNwNavGR4emmV0Vq9IRTeE-gzGzoHsz", "jukR11B6qIiKA7bRYTXBe8bd");</script>
<script type="text/javascript">
  var time=0
  var title=""
  var url=""
  var query = new AV.Query('Counter');
  query.notEqualTo('id',0);
  query.descending('time');
  query.limit(1000);
  query.find().then(function (todo) {
    for (var i=0;i<1000;i++){
      var result=todo[i].attributes;
      time=result.time;
      title=result.title;
      url=result.url;
      var content="<a href='"+"https://depthlove.github.io"+url+"'>"+title+"</a>"+"<br />"+"<font color='#555'>"+"阅读次数："+time+"</font>"+"<br /><br />";
      document.getElementById("top").innerHTML+=content
    }
  }, function (error) {
    console.log("error");
  });
</script>