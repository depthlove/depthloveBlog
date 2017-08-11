
{% if theme.gitment.enable %}
  {% set owner = theme.gitment.owner %}
  {% set repo = theme.gitment.repo %}
  {% set client_id = theme.gitment.client_id %}
  {% set client_secret = theme.gitment.client_secret %}
  <link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
  <script src="https://imsun.github.io/gitment/dist/gitment.browser.js"></script>
  {% if not theme.gitment.lazy %}
  <script type="text/javascript">
    var gitment = new Gitment({
      id: document.location.href, 
      owner: '{{owner}}',
      repo: '{{repo}}',
      oauth: {
      client_id: '{{client_id}}',
      client_secret: '{{client_secret}}',
    }});
    gitment.render('gitment-container');
  </script>
{% else %}
  <script type="text/javascript">
  function ShowGitment(){
  document.getElementById("gitment-display-button").style.display = "none";
  document.getElementById("gitment-container").style.display = "block";
  var gitment = new Gitment({
    id: document.location.href, 
    owner: '{{owner}}',
    repo: '{{repo}}',
    oauth: {
    client_id: '{{client_id}}',
    client_secret: '{{client_secret}}',
    }});
    gitment.render('gitment-container');
  }
  </script>
  {% endif %}
{% endif %}
