###
 grunt-webpage-scaffold
 https://github.com/Mickey-/webpage-scaffold

 Copyright (c) 2014 Mickey-
 Licensed under the MIT license.
###

'use strict'

module.exports = (grunt) ->

  grunt.registerMultiTask('webpage_scaffold', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', (pageName, ifNotNeedJs) ->
    require('colors')
    open = require('open')
    opt = grunt.config.get('options')
    demoRoot = 'http://localhost/git/moc/build/demos/'
    done = @async()

    options = this.options(
      punctuation: '.'
      separator: ', '
    )

    if !pageName
      grunt.fail.warn('请指定新项目模块名称,如： ' + 'grunt new:modname'.inverse + '。注意默认会在新demo文件' + 'modname.html'.underline + '里引入' + 'modname.js'.cyan + '和' + 'modname.css'.cyan)
    tplBuffer = grunt.file.read('./demos/.tpl.html')
    tplBuffer = tplBuffer.replace(/#{pagename}/g, pageName)
    files =
      html: './demos/' + pageName + '.html'
      less: './less/page/' + pageName + '.less'
      js: './js/page/' + pageName + '.js'
    if grunt.file.write(files.html, tplBuffer)
      grunt.log.ok(files.html.cyan + '生成成功！')
      if grunt.file.write(files.less, '.' + pageName + ' {\r\n\r\n}')
        grunt.log.ok(files.less.cyan + '生成成功！')
        if ifNotNeedJs == undefined
          if grunt.file.write(files.js, '')
            grunt.log.ok(files.js.cyan + '生成成功！')
            g = grunt.log.write('\n模块' + pageName.cyan + '构建中...')
            sc = grunt.util.spawn(
              cmd: 'grunt'
              ,(err, ret, code) ->
                if !err
                  g.ok()
                  console.log('\n进入开发模式'.yellow)
                  grunt.task.run(['watch'])
                  open(demoRoot + pageName + '.html')
                  done(true)
            )
  )
