var exec = require('child_process').exec;
// Hexo 2.x 用户复制这段
hexo.on('new', function(path){
    exec('open -a "/Applications/MacDown.app" ' + path);
});
// Hexo 3 用户复制这段
hexo.on('new', function(data){
    exec('open -a "/Applications/MacDown.app" ' + data.path);
});
