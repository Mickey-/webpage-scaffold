/*
 grunt-webpage-scaffold
 https://github.com/Mickey-/webpage-scaffold

 Copyright (c) 2014 Mickey-
 Licensed under the MIT license.
*/


(function() {
  'use strict';
  module.exports = function(g) {
    return g.registerMultiTask('webpage_scaffold', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', function(pageName, ifNotNeedJs) {
      var done, files, gruntIns, open, opt, sc, scriptType, styleType, tplBuffer, write, writeError, _ref, _ref1;
      require('colors');
      open = require('open');
      done = this.async();
      opt = this.options({
        coffee: false,
        js: 'js/page/',
        less: 'less/page/',
        sass: false,
        demo: 'demos/',
        watchPath: 'http://localhost/git/moc/build/demos/'
      });
      if (!pageName) {
        g.fail.warn('请指定新项目模块名称,如： ' + 'grunt init:modname'.inverse + '。注意默认会在新demo文件' + 'modname.html'.underline + '里引入' + 'modname.js'.cyan + '和' + 'modname.css'.cyan);
      }
      tplBuffer = g.file.read('./demos/.tpl.html');
      tplBuffer = tplBuffer.replace(/#{pagename}/g, pageName);
      write = g.file.write;
      styleType = (_ref = opt.sass) != null ? _ref : {
        'sass': 'less'
      };
      scriptType = (_ref1 = opt.coffee) != null ? _ref1 : {
        'coffee': 'js'
      };
      files = [
        {
          dest: opt.demo + pageName + '.html',
          content: tplBuffer,
          okLog: files.html.cyan + '生成成功！'
        }, {
          dest: opt[styleType] + pageName + '.' + styleType,
          content: '.' + pageName + ' {\r\n\r\n}',
          okLog: files.less.cyan + '生成成功！'
        }, {
          dest: opt[scriptType] + pageName + '.' + scriptType,
          content: '',
          okLog: files.less.cyan + '生成成功！',
          ifNotNeedJs: ifNotNeedJs
        }
      ];
      files.forEach(function(v, k) {
        if (v.ifNotNeedJs === void 0 || !v.ifNotNeedJs) {
          if (write(v.dest, v.content)) {
            return g.log.ok(v.okLog);
          } else {
            return writeError();
          }
        }
      });
      gruntIns = g.log.write('\n模块' + pageName.cyan + '构建中...');
      sc = g.util.spawn({
        cmd: 'grunt'
      }, function(err, ret, code) {
        if (!err) {
          gruntIns.ok();
          console.log('\n进入开发模式'.yellow);
          g.task.run(['watch']);
          open(opt.watchPath + pageName + '.html');
          return done(true);
        }
      });
      return writeError = function(msg) {
        return g.log.error(msg || '文件写入失败！');
      };
    });
  };

}).call(this);
