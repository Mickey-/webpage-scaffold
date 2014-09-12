###
 grunt-webpage-scaffold
 https://github.com/Mickey-/webpage-scaffold

 Copyright (c) 2014 Mickey-
 Licensed under the MIT license.
###

'use strict'

module.exports = (g) ->

  g.registerTask('webpage_scaffold', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', (pageName, ifNotNeedJs) ->
    require('colors')
    open = require('open')
    done = @async()

    opt = this.options(
      coffee: false
      js: 'js/page/'
      less: 'less/page/'
      sass: false
      demo: 'demos/'
      watchPath: 'http://localhost/git/moc/build/demos/'
      tplPath: '.tpl'
    )

    if !pageName
      g.fail.warn('请指定新项目模块名称,如： ' + 'grunt init:modname'.inverse + '。注意默认会在新demo文件' + 'modname.html'.underline + '里引入' + 'modname.js'.cyan + '和' + 'modname.css'.cyan)

    tplBuffer = g.file.read(opt.tplPath)
    tplBuffer = tplBuffer.replace(/#{pagename}/g, pageName)
    write = g.file.write
    styleType = (opt.sass ? 'sass' : 'less')
    scriptType = (opt.coffee ? 'coffee' : 'js')

    #默认内容
    files = [
      dest: opt.demo + pageName + '.html'
      content: tplBuffer
      okLog: files.html.cyan + '生成成功！'
    ,
      dest: opt[styleType] + pageName + '.' + styleType
      content: '.' + pageName + ' {\r\n\r\n}'
      okLog: files.less.cyan + '生成成功！'
    ,
      dest: opt[scriptType] + pageName + '.' + scriptType
      content: ''
      okLog: files.less.cyan + '生成成功！'
      #新模块是否需要js逻辑
      ifNotNeedJs: ifNotNeedJs
    ]

    #写文件
    files.forEach((v, k) ->
      if v.ifNotNeedJs == undefined || !v.ifNotNeedJs
        if write(v.dest, v.content)
          g.log.ok(v.okLog)
        else
          writeError()
    )

    gruntIns = g.log.write('\n模块' + pageName.cyan + '构建中...')
    sc = g.util.spawn(
      cmd: 'grunt'
      ,(err, ret, code) ->
        if !err
          gruntIns.ok()
          console.log('\n进入开发模式'.yellow)
          g.task.run(['watch'])
          open(opt.watchPath + pageName + '.html')
          done(true)
    )

    writeError = (msg) ->
      g.log.error(msg || '文件写入失败！')
  )
